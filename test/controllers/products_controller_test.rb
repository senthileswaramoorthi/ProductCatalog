require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  test "should get admin" do
    get :admin
    assert_response :success
  end

end
