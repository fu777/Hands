require "test_helper"

class Public::ShopOrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_shop_orders_index_url
    assert_response :success
  end

  test "should get show" do
    get public_shop_orders_show_url
    assert_response :success
  end
end
