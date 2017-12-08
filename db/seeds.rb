# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities  = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

managers = Manager.create([{:name => 'Charlie Powicki', :id => 25, :email => 'cpowicki@tulane.edu', :password => '1234'}])
properties = Property.create([{:name => 'Home', :address => '2224 Calhoun Street', :square_feet => 5000, :max_num_tenants => 4, :curr_num_tenants => 0, :monthly_rent => 4000, :manager_id => 25 }])