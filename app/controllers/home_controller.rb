# encoding: utf-8

class HomeController < ApplicationController
  respond_to :json, only: [ :add_message, :check_msg_limit ]
  def add_message
    phone = Phone.where(number: params[:phone]).first_or_create
    time = Time.parse("#{params[:date]} #{params[:time]}")
    time += cookies[:timezone].to_i.hours - Time.now.utc_offset
    if verify_recaptcha or phone.verified
      phone.update_attribute(:verified, true) unless phone.verified
      status, message = phone.add_message(params[:message], time)
      cookies.permanent[:phone] = params[:phone]
    else
      status = 'error'
      message = 'неверно введена капча'
    end
    respond_with({ status: status, message: message, paid_messages: phone.paid_messages, total_count: Rails.cache.read('messages_total') }, location: nil)
  end

  def check_msg_limit
    phone = Phone.where(number: params[:phone]).first_or_create
    respond_with({count: phone.paid_messages, verified: phone.verified})
  end
end
