class ZapierController < ApplicationController
  skip_before_action :verify_authenticity_token
  include ZapierHelper

  def incoming_grubhub_order
    #if store = Store.find_by_email(params['zapier']['Sender'])
    if store = Store.first
      email = Nokogiri::HTML(params['zapier']['HtmlDocument'])
      confirmation_link = order_confirmation_link(
        email,
        params['zapier']['reference']
      )
      order_params = params['zapier'].except('HtmlDocument').merge(
        { 'confirmation_link' => confirmation_link }
      )
      source_id = order_source_id(params['zapier']['Template'])

      if order = Order.find_by_number_and_store_id_and_source_id(params['zapier']['reference'], store.id, source_id)
        order.details = order_params
        order.name = params['zapier']['dropoffName']
        order.phone_number = params['zapier']['dropoffPhone']
      else
        order = store.orders.new({
          source_id: source_id,
          details: order_params,
          name: params['zapier']['dropoffName'],
          number: params['zapier']['reference'],
          phone_number: params['zapier']['dropoffPhone']
        })
      end

      if order.save
        render json: { created: true }, status: :created
      else
        render json: order.errors, status: :unprocessable_entity
      end
    else
      render json: { store: false }, status: :unprocessable_entity
    end
  end
end
