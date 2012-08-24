class ApplicationController < ActionController::Base
  protect_from_forgery

  def send_sms(phone, text)
    SmsApi.push_msg_nologin(SMS_CONFIG['login'], SMS_CONFIG['password'], phone, text)
  end
end
