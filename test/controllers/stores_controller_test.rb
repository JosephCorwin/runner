require 'test_helper'

class StoresControllerTest < ActionDispatch::IntegrationTest
  test "index should redirect for non-bosses" do
    get stores_url
    assert_redirected_to root_url
  end

  test "new should should redirect for non-bosses" do
    get new_stores_path
    assert_redirected_to root_url
  end

  test "edit should should redirect for non-bosses" do
    get edit_stores_path
    assert_redirected_to root_url
  end

  test "should get show" do
    get store_url
    assert_response :success
  end


end
