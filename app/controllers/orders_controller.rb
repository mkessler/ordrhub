class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_store
  before_action :set_organization, if: :store_belongs_to_organization?
  before_action :authenticate_user_store_access, unless: :store_belongs_to_organization?
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    semantic_breadcrumb @store.name, store_path(@store)
    semantic_breadcrumb 'Orders', store_orders_path(@store)
    set_meta_tags title: 'Orders'

    if params[:search]
      @orders = @store.orders.search(params['search']).order(:created_at).page params[:page]
      @show_view_all_button = true
      if @orders.blank?
        flash.now[:error] = 'No orders found matching search criteria. Showing all.'
        @orders = @store.orders.order(:created_at).page params[:page]
        @show_view_all_button = false
      end
    else
      @orders = @store.orders.order(:created_at).page params[:page]
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    semantic_breadcrumb @store.name, store_path(@store)
    semantic_breadcrumb 'Orders', store_orders_path(@store)
    semantic_breadcrumb "##{@order.number}", store_order_path(@store, @order)
    set_meta_tags title: "Order ##{@order.number}"
  end

  # GET /orders/new
  # def new
  #   @order = Order.new
  # end

  # GET /orders/1/edit
  # def edit
  # end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  # def destroy
  #   @order.destroy
  #   respond_to do |format|
  #     format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:store_id])
    end

    def set_order
      @order = @store.orders.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:store_id, :source_id)
    end
end
