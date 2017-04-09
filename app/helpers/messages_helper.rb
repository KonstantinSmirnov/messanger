module MessagesHelper

  def inbox_count(user)
    Message.where(recipient: user, is_read?: false).count
  end

  def message_status_icon(is_read)
    is_read == true ? 'circle-thin' : 'dot-circle-o'
  end

  def render_text_preview(text)
    truncate( render_text_with_tags(text), length: 100)
  end

  def render_text_with_tags(text)
    sanitize text, tags: ['b', 'i', 'strong', 'a']
  end
  
  def sortable(column, title = nil, params)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, { :sort => column, :direction => direction, :outbox => params[:outbox] }, { :class => css_class }
  end
end
