require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
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
    assert_difference 'User.count' do
      post signup_path, params: { user: { first_name:            "John",
                                          last_name:             "Peterson",
                                          email:                 @random_email,
                                          password:              "testpass123",
                                          password_confirmation: "testpass123",
                                          phone:                 "1234567890",
                                          status:                "test" } }
    end
    follow_redirect!
    assert_template 'static/home'
    assert_select 'div.alert-success'
  end
end
