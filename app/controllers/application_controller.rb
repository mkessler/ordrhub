class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  semantic_breadcrumb 'Dashboard', :root_path

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
end
