require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(first_name: "Rodger",
		         last_name: "Goodman",
		         email: "rgoodman@example.com",
		         phone: "7859635216",
		         adr_street: "123 Good pl",
		         adr_street2: "Apt. 1",
		         adr_city: "Goodtown",
		         adr_state: "TX",
		         adr_zip: "78887",
		         status: "good",
			 password: "testpass123",
			 password_confirmation: "testpass123" )
  end
  
  test "user example passes" do
    assert @user.valid?
  end

  test "first name not too long" do
    @user.first_name = "a"*65
    assert_not @user.valid?
  end

  test "last name not too long" do
    @user.last_name = "a"*65
    assert_not @user.valid?
  end

  test "phone strips out invalid characters" do
    sorta_valid_phones = ["(785) 936-5216", "4(32)521(4432)", "%%%8512486957", ]
    sorta_valid_phones.each do |sorta_valid|
      @user.phone = sorta_valid
      assert @user.valid?, "I guess #{sorta_valid.inspect} doesn't work, okay?"
    end
  end

  test "adr_street should not be empty" do
    @user.adr_street = "   "
    assert_not @user.valid?
  end

  test "adr_city should not be empty" do
    @user.adr_city = "    "
    assert_not @user.valid?
  end
 
  test "adr_state should not be empty" do
    @user.adr_state = "    "
    assert_not @user.valid?
  end

#  test "adr_zip should not be too short or long" do
#    bad_zips = ["12", "12345-6789000"]
#    bad_zips.each do |bad_zip|
#      @user.adr_zip = bad_zip
#      assert_not @user.valid?
#    end
#  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 8
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 7
    assert_not @user.valid?
  end

end
