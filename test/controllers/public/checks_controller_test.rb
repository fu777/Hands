require "test_helper"

class Public::ChecksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_checks_index_url
    assert_response :success
  end
end
