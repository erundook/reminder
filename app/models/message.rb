class Message < ActiveRecord::Base
  belongs_to :phone

  validates_presence_of :text, :requested_time, :phone
  validates_length_of :text, maximum: 50

  after_create :charge_and_queue
  attr_accessible :text, :requested_time, :delivery_time, :raw_size, :provider_response, :error_log

  state_machine :state, :attribute => :state, :initial => :queued do
    event :send_now do
      transition :queued => :processing
    end
    event :failed do
      transition :processing => :message_failed
    end
    event :sent do
      transition :processing => :message_sent
    end
    after_transition :queued => :processing, :do => :deliver
    after_transition :processing => :failed, :do => :refund
    after_transition :processing => :message_sent,  :do => :update_stats
  end

  def deliver
    puts 'delivering'
    begin
      response = phone.send_message(text)
      unless response
        failed!
        return false
      end
      update_attributes(
                         delivery_time: Time.now,
                         provider_response: response.to_json,
                         raw_size: response['n_raw_sms']
                        )
      sent!
    rescue => e
      update_attribute(:error_log, e.inspect)
      logger.error "DELIVERY FALIED: #{self.inspect}\n#{e.inspect}"
      failed!
    end
  end

  def update_stats
    Rails.cache.write('messages_total', Message.count)
  end

  def charge_and_queue
    phone.update_attribute(:paid_messages, phone.paid_messages - 1)
    Resque.enqueue_at(requested_time, SendMessage, message_id: id)
  end

  def refund
    phone.update_attribute(:paid_messages, phone.paid_messages + 1)
  end
end
