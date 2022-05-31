require "test_helper"

class Public::ShopNoticesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_shop_notices_index_url
    assert_response :success
  end
end
