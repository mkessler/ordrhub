module ApplicationHelper
  def flash_class(type)
    case type
      when 'success'
        'ui green message'
      when 'error'
        'ui red message'
      when 'notice'
        'ui blue message'
      else
        'ui message'
    end
  end

  def menu_item_is_active?(item)
    params[:controller].include?(item) ||
      item == 'stores' && params[:controller] == 'orders'
  end

  def user_display_name
    if user_name_set?
      current_user.user_name
    else
      current_user.email
    end
  end

  def user_name_set?
    current_user.user_name.present?
  end
end
