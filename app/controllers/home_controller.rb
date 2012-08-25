class HomeController < ApplicationController
  respond_to :json, only: [ :add_message ]
  def add_message
    respond_with({status: 'ok'}, location: nil)
  end
end
