require 'test_helper'

class ZapierControllerTest < ActionDispatch::IntegrationTest
  test "should get incoming_order" do
    get zapier_incoming_order_url
    assert_response :success
  end

end
