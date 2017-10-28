class ZapierController < ApplicationController
  skip_before_action :verify_authenticity_token
  include ZapierHelper

  def incoming_grubhub_order
    store = Store.first
    email = Nokogiri::HTML(params['zapier']['HtmlDocument'])
    confirmation_link = email.search('a[href*="orderemails.grubhub.com"]').first.attributes['href'].value
    order_params = params['zapier'].except('HtmlDocument').merge(
      { 'confirmation_link' => confirmation_link }
    )

    order = store.orders.new({
      source_id: order_source_id(params['zapier']['Template']),
      details: order_params
    })

    respond_to do |format|
      if order.save
        format.json { render json: { created: true }, status: :created }
      else
        format.json { render json: order.errors, status: :unprocessable_entity }
      end
    end
  end
end
