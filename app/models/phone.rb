class Phone < ActiveRecord::Base
  attr_accessible :number
  has_many :messages, :dependent => :destroy

  validates_presence_of :number
  validates_format_of :number, with: /\A7\d{10}/

  def send_message(text)
    open("http://sms.ru/sms/send?api_id=#{SMS_CONFIG['key']}&to=#{number}&text=#{URI::encode(text)}").read
  end

  def add_message(text, requested_time)
    if paid_messages > 0
      messages.create(text: text, requested_time: requested_time)
    else
      # report an error
    end
  end
end
