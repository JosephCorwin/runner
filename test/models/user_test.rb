require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @good_user = User.new(first_name: "Rodger",
		         last_name: "Goodman",
		         email: "rgoodman@example.com",
		         phone: "7859635216",
		         adr_street: "123 Good pl",
		         adr_street2: "Apt. 1",
		         adr_city: "Goodtown",
		         adr_state: "TX",
		         adr_zip: "78887",
		         status: "good", )

    @shit_user = User.new(first_name: "Ro(&dge''r#@!;;",
		         last_name: "Shit---/?='fuckyou={{*'man",
		         email: "rgo.od?man@examplecom/",
		         phone: "lololololol",
		         adr_street: "%%%%%coolstory_bro",
		         adr_street2: "idgaf",
		         adr_city: "shit*&[[stains];burg",
		         adr_state: "FTW",
		         adr_zip: "nnnnnn-oooo",
		         status: "prob", )

    @poor_user = User.new(first_name: "Rodger",
		         last_name: "Poodman",
		         email: "rroodman@examplecom",
		         phone: "785.963-5216",
		         adr_street: "123 Good pl",
		         adr_street2: "Apt.",
		         adr_city: "Goodtown",
		         adr_state: "TX",
		         adr_zip: "7888",
		         status: "news", )

    @goof_user = User.new(first_name: "Rodger" + " "*64,
		         last_name: "",
		         email: "",
		         phone: "",
		         adr_street: "",
		         adr_street2: "",
		         adr_city: "",
		         adr_state: "",
		         adr_zip: "",
		         status: "", )
   end
   
   test "no trouble in paradise" do
     assert @good_user.valid?
     assert_not @shit_user.valid?
     assert_not @poor_user.valid?
     assert_not @goof_user.valid?
   end

end
