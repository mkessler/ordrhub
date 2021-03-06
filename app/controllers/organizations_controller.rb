class OrganizationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organization, only: [:show, :edit, :update, :destroy]
  semantic_breadcrumb 'Organizations', :organizations_path, except: [:index]

  # GET /organizations
  # GET /organizations.json
  def index
    set_meta_tags title: 'Organizations'
    @organizations = current_user.organizations
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
    semantic_breadcrumb @organization.name, organization_path(@organization)
    set_meta_tags title: @organization.name
    @stores_count = @organization.stores.count
    @users_count = @organization.users.count
  end

  # GET /organizations/new
  def new
    semantic_breadcrumb 'New Organization', :new_organization_path
    set_meta_tags title: 'New Organization'
    @organization = Organization.new
  end

  # GET /organizations/1/edit
  def edit
    semantic_breadcrumb @organization.name, organization_path(@organization)
    semantic_breadcrumb 'Edit', edit_organization_path(@organization)
    set_meta_tags title: "Edit #{@organization.name}"
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(organization_params)

    respond_to do |format|
      if @organization.save
        @organization.memberships.create(user: current_user)
        format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
        format.json { render :show, status: :created, location: @organization }
      else
        format.html { render :new }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
        format.json { render :show, status: :ok, location: @organization }
      else
        format.html { render :edit }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  # def destroy
  #   @organization.destroy
  #   respond_to do |format|
  #     format.html { redirect_to organizations_url, notice: 'Organization was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = current_user.organizations.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:name)
    end
end
