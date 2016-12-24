require 'test_helper'

class CustomerTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
  end

  test "sanity" do
    #user method to create customer account works
    assert_difference 'Customer.count', 1 do
      @user.create_account!
    end
    
    #creating a user automatically creates a customer account
    assert_difference 'Customer.count', 1 do
      assert_difference 'User.count', 1 do

        post signup_path, params: { user: { first_name:            "John",
                                            last_name:             "Peterson",
                                            email:                 "jp@example.com",
                                            password:              "testpass123",
                                            password_confirmation: "testpass123",
                                            phone:                 "1234567890" } }
      end

    end

  end
  
end
