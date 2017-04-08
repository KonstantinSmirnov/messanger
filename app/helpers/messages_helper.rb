module MessagesHelper

  def inbox_count(user)
    Message.where(recipient: user, is_read?: false).count
  end

  def message_status_icon(is_read)
    is_read == true ? 'circle-thin' : 'circle'
  end

  def render_text_with_tags(text)
    sanitize text, tags: ['b', 'i', 'strong', 'a']
  end

  def render_text_preview(text)
    truncate( render_text_with_tags(text), length: 100)
  end
end
