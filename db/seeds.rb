# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Make the boss and optimus
boss = User.create!(    first_name: "Bossman",
                         last_name: "Bobby",
                             email: "bossman@runnerdeliveries.com",
                             phone: "7418520963",
                          password: "password",
             password_confirmation: "password",
                            status: "boss",
                         activated: "true",
                      activated_at: Time.zone.now )


optimus = User.create!( first_name: "Optimus",
                         last_name: "Prime",
                             email: "op@auto.bots",
                             phone: "4628862687",
                          password: "password",
             password_confirmation: "password",
                            status: "runn")
optimus.activate!
optimus.is_hired!
                       
#Make some runners
10.times do |n|
  name1 = "Runner #{n+1}"
  name2 = "Runnn"
  user = User.create!(  first_name: name1,
                         last_name: name2,
                             email: "runner#{n+1}@example.com",
                             phone: (0..9).to_a.shuffle.join,
                          password: "password",
             password_confirmation: "password",
                            status: "runn" )
  user.activate!
  user.is_hired!
end

#make some former runners
5.times do |n|
  name1 = "Fired #{n+1}"
  name2 = "Gohome"
  user = User.create!(  first_name: name1,
                         last_name: name2,
                             email: "fired#{n+1}@example.com",
                             phone: (0..9).to_a.shuffle.join,
                          password: "password",
             password_confirmation: "password",
                            status: "prob" )
  user.activate!
  user.is_hired!
  user.is_fired!
end

#make some cusomters
50.times do |n|
  name1 = "Customer #{n+1}"
  name2 = "Buysstuff"
  user = User.create!(  first_name: name1,
                         last_name: name2,
                             email: "customer#{n+1}@example.com",
                             phone: (0..9).to_a.shuffle.join,
                          password: "password",
             password_confirmation: "password" )
  user.activate!
end

#make some new signups
5.times do |n|
  name1 = "Noob #{n+1}"
  name2 = "Newguy"
  user = User.create!(  first_name: name1,
                         last_name: name2,
                             email: "noob#{n+1}@example.com",
                             phone: (0..9).to_a.shuffle.join,
                          password: "password",
             password_confirmation: "password" )
end

#make some orders
User.where(status: 'good').each do |u|
  5.times do
    order = u.account.orders.create!(what_they_want: "Stuff!", where_it_goes: "Places!")
  end
end
Order.all.each do |o| #assign the orders
  o.update_attribute(:runner_id, rand(2..11))
end
