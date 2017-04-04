module MessagesHelper
  
  def inbox_count(user)
    Message.where(recipient: user, is_read?: false).count
  end

  def message_status_icon(is_read)
    is_read == true ? 'circle-thin' : 'circle'
  end
end
