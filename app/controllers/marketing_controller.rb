class MarketingController < ApplicationController
  layout 'simple', only: [:privacy_policy]

  def index
    @lead = Lead.new
  end

  def privacy_policy
  end
end
