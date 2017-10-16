class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.organizations.count > 1
      redirect_to organizations_path
    elsif current_user.organizations.count > 0
      redirect_to organization_path(
        current_user.organizations.first
      )
    elsif current_user.associations.count > 1
      redirect_to stores_path
    elsif current_user.associations.count > 0
      redirect_to store_path(
        current_user.stores.first
      )
    else
      redirect_to home_index_path
    end
  end
end
