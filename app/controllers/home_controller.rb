# encoding: utf-8

class HomeController < ApplicationController
  respond_to :json, only: [ :add_message ]
  def add_message
    phone = Phone.where(number: params[:phone]).first_or_create
    time = Time.parse("#{params[:date]} #{params[:time]}")
    status, message = phone.add_message(params[:message], time)
    respond_with({ status: status, message: message }, location: nil)
  end
end
