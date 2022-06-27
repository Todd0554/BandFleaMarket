require "test_helper"

class MyorderControllerTest < ActionDispatch::IntegrationTest
  test "should get success" do
    get myorder_success_url
    assert_response :success
  end

  test "should get myorder" do
    get myorder_myorder_url
    assert_response :success
  end
end
