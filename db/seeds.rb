# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
properties = Property.create([{ :name => 'Example Property', :address => '123 Main Street, New Orleans LA 70118', :square_feet => 5000,
                               :max_num_tenants => 4, :curr_num_tenants => 3, :monthly_rent => 3200, :notes => "Definitely a property." }])
                               
                               
landlords = Landlord.create([{:first_name=>'Example',:last_name=> 'Landlord', :office_address=>'123 Main', :phone_number=>'123456789', :email=>'land@lord.com', :notes=>"I am the best landloard ever"}])