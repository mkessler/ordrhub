class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def postmates_client
    @postmates_client ||= Postmates.new.configure do |config|
      config.api_key     = "KA.eyJ2ZXJzaW9uIjoyLCJpZCI6Im01N0VWT1VwUnQrakRLUGNLZ3phaGc9PSIsImV4cGlyZXNfYXQiOjE1MTA2NDI0MTEsInBpcGVsaW5lX2tleV9pZCI6Ik1RPT0iLCJwaXBlbGluZV9pZCI6MX0.lI8ZlfF_AMhTLZpWf3ntn8niXhygqrhTLm07BR4qTKQ"
      config.customer_id = "yWmMZB7E3AJmmTzQUX5a183Ww4bLGuiN"
    end
  end

  def uber_client
    @uber_client ||= Uber::Client.new do |config|
      config.server_token  = "KA.eyJ2ZXJzaW9uIjoyLCJpZCI6Im01N0VWT1VwUnQrakRLUGNLZ3phaGc9PSIsImV4cGlyZXNfYXQiOjE1MTA2NDI0MTEsInBpcGVsaW5lX2tleV9pZCI6Ik1RPT0iLCJwaXBlbGluZV9pZCI6MX0.lI8ZlfF_AMhTLZpWf3ntn8niXhygqrhTLm07BR4qTKQ"
      config.client_id     = "yWmMZB7E3AJmmTzQUX5a183Ww4bLGuiN"
      config.client_secret = "6j44nwRHkgxlqc9qBOUSMQ93D2aed513cGQ1HKOD"
      config.sandbox       = true
    end
  end
end
