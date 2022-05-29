require "test_helper"

class Public::CustomersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_customers_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_customers_edit_url
    assert_response :success
  end

  test "should get profile_edit" do
    get public_customers_profile_edit_url
    assert_response :success
  end

  test "should get good" do
    get public_customers_good_url
    assert_response :success
  end

  test "should get favourite" do
    get public_customers_favourite_url
    assert_response :success
  end

  test "should get unsubscribe" do
    get public_customers_unsubscribe_url
    assert_response :success
  end
end
