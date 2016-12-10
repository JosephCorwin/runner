require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
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
    get edit_user_path(@user)
    assert_template 'users/edit'
    first_name  = "Foo"
    last_name = "Bar"
    email = "foo@bar.com"
    phone = "1112223333"
    password = "testpass123"
    patch user_path(@user), params: { user: { first_name:            first_name,
                                              last_name:             last_name,
                                              email:                 email,
                                              phone:                 phone,
                                              password:              password,
                                              password_confirmation: password } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal first_name,  @user.first_name
    assert_equal last_name,   @user.last_name
    assert_equal email,       @user.email
  end

end
