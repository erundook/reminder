module SendMessage
  @queue = :messages
  def self.perform(params)
    Message.find(params['message_id']).send_now!
  end
end
