class ZapierController < ApplicationController
  skip_before_action :verify_authenticity_token

  def incoming_order
    store = Store.first
    order = store.orders.new({
      source_id: Source.first.id
    }.merge(params[:zapier]))

    respond_to do |format|
      if order.save
        format.json { render json: { created: true }, status: :created }
      else
        format.json { render json: order.errors, status: :unprocessable_entity }
      end
    end
  end
end
