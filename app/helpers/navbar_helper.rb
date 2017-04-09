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
        return 'active' if controller?('messages') && action?('index') && params[:outbox] != 'true'
      when 'Sent'
        return 'active' if controller?('messages') && (params[:outbox] == 'true')
      when 'Drafts'
        return 'active' if controller?('drafts')
      when 'Login'
        return 'active' if controller?('sessions') && action?('new')
      when 'Register'
        return 'active' if controller?('users') && action?('new')
    end
  end
end
