module SendMessage
  @queue = :messages
  def self.perform(params)
    begin
      msg = Message.find(params['message_id'])
      puts "sending message to #{msg.phone.number}: #{msg.text}"
      msg.send_now!
    rescue => e
      puts e.inspect
      msg.update_attribute(:error_log, e.inspect)
      msg.failed!
    end
  end
end
