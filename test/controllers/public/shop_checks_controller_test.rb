require "test_helper"

class Public::ShopChecksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_shop_checks_index_url
    assert_response :success
  end
end
