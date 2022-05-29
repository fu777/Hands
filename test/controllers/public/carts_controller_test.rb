require "test_helper"

class Public::CartsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_carts_index_url
    assert_response :success
  end
end
