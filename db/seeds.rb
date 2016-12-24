# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

boss = User.create!(first_name: "Bossman",
                    last_name:  "Bobby",
                    email:      "bossman@runnerdeliveries.com",
                    phone:      "7418520963",
                    password:   "password",
       password_confirmation:   "password",
                   status:     "boss" )
boss.activate

optimus = User.create!(first_name: "Optimus",
                       last_name:  "Prime",
                       email:      "op@auto.bots",
                       phone:      "4628862687",
                       password:   "password",
          password_confirmation:   "password",
                       status:     "runn")
optimus.activate
optimus.is_hired!
                       

10.times do |n|
  name1 = "Runner #{n+1}"
  name2 = "Runnn"
  user = User.create!(first_name: name1,
                      last_name:  name2,
                      email:      "runner#{n+1}@example.com",
                      phone:      (0..9).to_a.shuffle.join,
                      password:   "password",
         password_confirmation:   "password",
                      status:     "runn" )
  user.activate
  user.is_hired!
end

50.times do |n|
  name1 = "Customer #{n+1}"
  name2 = "Buysstuff"
  user = User.create!(first_name: name1,
                      last_name:  name2,
                      email:      "customer#{n+1}@example.com",
                      phone:      (0..9).to_a.shuffle.join,
                      password:   "password",
         password_confirmation:   "password" )
  user.activate
end

5.times do |n|
  name1 = "Noob #{n+1}"
  name2 = "Newguy"
  user = User.create!(first_name: name1,
                      last_name:  name2,
                      email:      "noob#{n+1}@example.com",
                      phone:      (0..9).to_a.shuffle.join,
                      password:   "password",
         password_confirmation:   "password" )
end
