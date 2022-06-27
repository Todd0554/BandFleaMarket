require "test_helper"

class MycartControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get mycart_index_url
    assert_response :success
  end
end
