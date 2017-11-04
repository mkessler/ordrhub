class StoresController < ApplicationController
  before_action :authenticate_user!, except: [:incoming_order]
  before_action :set_store, only: [:show, :edit, :update, :destroy]
  before_action :set_organization, except: [:index, :incoming_order], if: :store_belongs_to_organization?
  before_action :authenticate_user_store_access, except: [:index, :new, :create, :incoming_order], unless: :store_belongs_to_organization?
  #semantic_breadcrumb @organization.name, organization_path(@organization), if: :store_belongs_to_organization?
  semantic_breadcrumb 'Stores', :stores_path, except: [:index, :incoming_order]

  # GET /stores
  # GET /stores.json
  def index
    @stores = Kaminari.paginate_array(current_user.all_stores).page(params[:page]).per(25)
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
    semantic_breadcrumb @store.name, store_path(@store)
    @orders_count = @store.orders.count
    @users_count = @store.users_count
  end

  # GET /stores/new
  def new
    semantic_breadcrumb 'Add Store', :new_store_path
    @store = Store.new
  end

  # GET /stores/1/edit
  def edit
    semantic_breadcrumb @store.name, store_path(@store)
    semantic_breadcrumb 'Edit', edit_store_path(@store)
  end

  # POST /stores
  # POST /stores.json
  def create
    @store = Store.new(store_params)

    respond_to do |format|
      if @store.save
        format.html { redirect_to @store, notice: 'Store was successfully created.' }
        format.json { render :show, status: :created, location: @store }
      else
        format.html { render :new }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stores/1
  # PATCH/PUT /stores/1.json
  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to @store, notice: 'Store was successfully updated.' }
        format.json { render :show, status: :ok, location: @store }
      else
        format.html { render :edit }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  # def destroy
  #   @store.destroy
  #   respond_to do |format|
  #     format.html { redirect_to stores_url, notice: 'Store was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  def incoming_order
    puts "Order received!"
    puts params
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = current_user.stores.find_by_id(params[:id]) ||
        Store.find_by_id_and_organization_id!(
          params[:id],
          current_user.organizations.map(&:id)
        )
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.require(:store).permit(:organization_id, :name)
    end
end
