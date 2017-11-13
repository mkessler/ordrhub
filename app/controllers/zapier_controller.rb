class ZapierController < ApplicationController
  skip_before_action :verify_authenticity_token
  include ZapierHelper

  def incoming_grubhub_order
    if store = Store.find_by_email(params['zapier']['Sender'])
      email = Nokogiri::HTML(params['zapier']['HtmlDocument'])
      confirmation_link = order_confirmation_link(
        email,
        params['zapier']['reference']
      )
      order_params = params['zapier'].except('HtmlDocument').merge(
        { 'confirmation_link' => confirmation_link }
      )

      if order = Order.find_by_number(params['zapier']['reference'])
        order.details = order_params
        order.name = params['zapier']['dropoffName']
        order.phone_number = params['zapier']['dropoffPhone']
      else
        order = store.orders.new({
          source_id: order_source_id(params['zapier']['Template']),
          details: order_params,
          name: params['zapier']['dropoffName'],
          number: params['zapier']['reference'],
          phone_number: params['zapier']['dropoffPhone']
        })
      end

      respond_to do |format|
        if order.save
          format.json { render json: { created: true }, status: :created }
        else
          format.json { render json: order.errors, status: :unprocessable_entity }
        end
      end
    else
      format.json { render json: { store: false }, status: :unprocessable_entity }
    end
  end
end
