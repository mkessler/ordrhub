module ApplicationHelper
  def menu_item_is_active?(item)
    params[:controller].include?(item)
  end
end
