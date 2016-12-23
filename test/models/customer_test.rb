require 'test_helper'

class CustomerTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
  end

  test "sanity" do
    assert_difference 'Customer.count', 1 do
      @user.create_account!
    end
  end
  
end
