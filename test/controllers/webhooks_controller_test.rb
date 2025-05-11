require "test_helper"

class WebhooksControllerTest < ActionDispatch::IntegrationTest
  test "should get monopay" do
    get webhooks_monopay_url
    assert_response :success
  end
end
