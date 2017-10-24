class ZapierController < ApplicationController
  skip_before_action :verify_authenticity_token

  def incoming_order
  end
end
