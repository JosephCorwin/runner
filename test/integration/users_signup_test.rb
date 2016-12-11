require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "Invalid signup" do
    get signup_path
    assert_select 'form[action="/signup"]'
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name:                  "",
                                          email:                 "user@invalid",
                                          password:              "foo",
                                          password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
  end

  test "Valid signup" do
    @random_email = (1..5).to_a.shuffle.join + '@' + (1..5).to_a.shuffle.join + '.com'
    get signup_path
    assert_select 'form[action="/signup"]'
    assert_difference 'User.count', 1 do
      post signup_path, params: { user: { first_name:            "John",
                                          last_name:             "Peterson",
                                          email:                 @random_email,
                                          password:              "testpass123",
                                          password_confirmation: "testpass123",
                                          phone:                 "1234567890",
                                          status:                "test" } }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    # you can't log in yet
    log_in_as(user)
    assert_not logged_in?
    # you need the right token
    get edit_account_activation_path("invalid token", email: user.email)
    assert_not logged_in?
    # you also need the right email
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not logged_in?
    # there we go
    get edit_account_activation_path(user.activation_token, email: user.email)
    follow_redirect!
    assert_template 'users/show'
    assert logged_in?
  end
end
