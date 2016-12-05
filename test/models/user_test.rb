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
		         status: "good", )
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
     	assert @user.valid?, "I guess #{sorta_valid.inspect} can work okay"
     end
   end

end
