# encoding: utf-8

class Phone < ActiveRecord::Base
  attr_accessible :number
  has_many :messages, :dependent => :destroy

  validates_presence_of :number
  validates_format_of :number, with: /\A\d{10}$/

  def send_message(text)
    url = "http://sms.ru/sms/send?api_id=#{SMS_CONFIG['key']}&from=#{URI::encode(SMS_CONFIG['from'])}&to=#{number}&text=#{URI::encode(text)}"
    data = open(url).read
    data
  end

  def add_message(text, requested_time)
    status = 'error'
    if valid?
      if paid_messages > 0
        if true#requested_time.utc > Time.now.utc + 5.minutes
          status = 'ok'
          messages.create(text: text, requested_time: requested_time)
          message = "Добавлено для доставки в #{requested_time.to_s(:short)}, осталось сообщений: #{paid_messages}"
        else
          message = "Неверное время отправки"
        end
      else
        message = "Исчерпан лимит сообщений"
      end
    else
      message = phone.errors.full_messages.join(', ')
    end
    [ status, message ]
  end
end
