module NavbarHelper
  
  def controller?(controller)
    controller.include?(params[:controller])
  end

  def action?(action)
    action.include?(params[:action])
  end

  def active_nav?(nav_name)
    case nav_name
      when 'New message'
        return 'active' if controller?('messages') && action?('new')
      when 'Inbox'
        return 'active' if controller?('messages') && (action?('index') || action?('show'))
      when 'Outbox'
        return ''
      when 'Drafts'
        return 'active' if controller?('drafts')
    end
  end
end
