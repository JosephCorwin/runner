require 'test_helper'

class StoresControllerTest < ActionDispatch::IntegrationTest

  def setup
    @store1 = stores(:Store_1)
    @store2 = stores(:Store_2)
  end

  test "index should redirect for non-bosses" do
    get stores_url
    assert_equal flash[:danger], "That's my purse I don't know you!"
    assert_redirected_to root_url
  end

  test "new should should redirect for non-bosses" do
    get new_stores_path
    assert_redirected_to root_url
  end

  test "edit should should redirect for non-bosses" do
    get edit_store_path(@store1)
    assert_redirected_to root_url
  end

  test "should get show" do
    get store_url(@store1)
    assert_response :success
  end


end
