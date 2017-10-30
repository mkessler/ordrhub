class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def authenticate_user_store_access
    unless Association.exists?(store_id: @store.id, user_id: current_user.id)
      flash[:alert] = "When you're a spy..."
      redirect_to stores_path
    end
  end

  def set_organization
    @organization = current_user.organizations.find(@store.organization_id)
  end

  def store_belongs_to_organization?
    @store.try(:organization_id?)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end
end
