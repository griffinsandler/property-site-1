# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities  = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



managers = Manager.create([{:name => 'Professor Kurdia', :id => 1000, :email => 'gsandler@tulane.edu', :password => '1234'}])
properties = Property.create([{:name => 'Home', :address => '2224 Calhoun Street', :square_feet => 5000, :max_num_tenants => 4, :curr_num_tenants => 0, :monthly_rent => 4000, :manager_id => 1000 }])
property_list = [
  [ "Menage", '1234 Broadway', 5000, 4, 0, 10000, 1000],
  [ "Urban Pancake", '2222 Calhoun St', 4000, 4, 0, 2000, 1000],
  [ "QuizMe", '45 Palmer Ave', 3000, 3, 0, 3000, 1000],
  [ "RenTUL", '44 Bourbon St', 2000, 4, 0, 5000, 1000],
  [ "Extinguish", '1000 St. Charles', 4000, 4, 0, 1750, 1000]
]

property_list.each do |name, address, sq, max, curr, rent, manager_id|
  Property.create( name: name, address: address, square_feet: sq, max_num_tenants: max, curr_num_tenants: curr, monthly_rent: rent, manager_id: manager_id) 
end

