require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
 

  def setup
    @user       = users(:michael)
    @other_user = users(:archer)
  end

 test "should get signup" do
    get signup_url
    assert_response :success
  end

  test "should redirect edit to login if not logged in" do
    get edit_user_path(@user)
    assert_redirected_to login_url
  end

  test "should redirect update to login if not logged in" do
    patch user_path(@user), params: @edit_params
    assert_redirected_to login_url
  end

  test "users should not be able to edit each other" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "users really should not be able to edit each other" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { first_name: @user.first_name,
                                              last_name:  @user.last_name,  
                                              email:      @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end

end
