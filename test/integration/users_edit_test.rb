require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user =          users(:michael)
    @other_user =    users(:archer)
 
    @edit_params = { user: { first_name:            "Foo",
                             last_name:             "Bar",
                             email:                 "foo@bar.com",
                             phone:                 "1112223333",
                             password:              "testpass123",
                             password_confirmation: "testpass123" } }
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'users/edit'
    assert_select 'div.alert-danger', { text: "The form contains 4 errors." }
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    first_name  = "Foo"
    last_name = "Bar"
    email = "foo@bar.com"
    phone = "1112223333"
    password = "testpass123"
    patch user_path(@user), params: @edit_params
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal first_name,  @user.first_name
    assert_equal last_name,   @user.last_name
    assert_equal email,       @user.email
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
    patch user_path(@user), params: @edit_params
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    patch user_path(@user), params: @edit_params
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @edit_params[:user][:first_name],  @user.first_name
    assert_equal @edit_params[:user][:last_name],   @user.last_name
    assert_equal @edit_params[:user][:email],       @user.email
  end

end
