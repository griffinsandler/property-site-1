# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities  = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

managers = Manager.create([{:name => 'Landlord 25', :id => 25}])

properties = Property.create([{ :name => 'Example Property', :address => '123 Main Street, New Orleans LA 70118', :square_feet  => 5000,
                               :max_num_tenants => 4, :curr_num_tenants => 3, :monthly_rent => 3200, :notes => "Definitely a property.", :manager_id => 25 }])
                             
tenants  = Tenant.create([{:name =>'Jordyn Saviet', :phone_number =>'1234567890', :email =>'jordyn@saviet.com', :property_id => 5, :password => 'password'}])
tenants  = Tenant.create([{:name =>'Lily Pollard', :phone_number =>'9876543210', :email =>'lily@pollard.edu', :property_id => 7, :password => 'password'}])
tenants  = Tenant.create([{:name =>'Dan Wills', :phone_number =>'4561237890', :email =>'dan@wills.edu', :property_id => 8, :password => 'password'}])
tenants  = Tenant.create([{:name =>'Brad Silk', :phone_number =>'1239874560', :email =>'Brad@silk.edu', :property_id => 9, :password => 'password'}])
tenants  = Tenant.create([{:name =>'Joe Stokes', :phone_number =>'1357908642', :email => 'joe@stokes.org', :property_id => 11, :password => 'password'}])
tenants  = Tenant.create([{:name =>'Jessie Grant', :phone_number =>'1325476980', :email =>'jessie@grant.gov', :property_id => 5, :password => 'password'}])
tenants  =Tenant.create([{:name =>'Sam Levy', :phone_number =>'0987654321', :email =>'sam@levy.com', :property_id => 7, :password => 'password'}])
tenants  =Tenant.create([{:name =>'Sam Springer', :phone_number =>'9876543210', :email =>'sam@springer.edu', :property_id => 8, :password => 'password'}])
tenants  =Tenant.create([{:name =>'Andrew Kirsh', :phone_number =>'0897645312', :email =>'andrew@kirsh.gov', :property_id => 9, :password => 'password'}])
tenants  =Tenant.create([{:name =>'Madison Wagman', :phone_number =>'1029384756', :email =>'madison@wagman.com', :property_id => 11, :password => 'password'}])
tenants  =Tenant.create([{:name =>'Adam Slavick', :phone_number =>'0912348765', :email =>'adam@slavick.edu', :property_id => 5, :password => 'password'}])
tenants  =Tenant.create([{:name =>'Julian Ungar', :phone_number =>'5647382910', :email =>'julian@ungar.edu', :property_id => 7, :password => 'password'}])
tenants  =Tenant.create([{:name =>'Chuck Rogers', :phone_number =>'6574839201', :email =>'chuck@rogers.com', :property_id => 8, :password => 'password'}])
tenants  =Tenant.create([{:name =>'Aaron Wolfe', :phone_number =>'7865231940', :email =>'aaron@wolfe.com', :property_id => 9 , :password => 'password'}])
tenants  =Tenant.create([{:name =>'Amanda Deutsch', :phone_number =>'9854123780', :email =>'amanda@deutsch.org', :property_id => 11, :password => 'password'}])
tenants  =Tenant.create([{:name =>'Sydney Kerzner', :phone_number =>'5043192786', :email =>'sydney@kerzner.edu', :property_id => 5, :password => 'password'}])
tenants  =Tenant.create([{:name =>'Jackson Parker', :phone_number =>'5046789321', :email =>'jackson@parker.dog', :property_id => 7, :password => 'password'}])
tenants  =Tenant.create([{:name =>'Kobe Bryant', :phone_number =>'5041236789', :email =>'kobe@bryant.com', :property_id => 8 , :password => 'password'}])
tenants  =Tenant.create([{:name =>'Cody Belinger', :phone_number =>'5041237869', :email =>'cody@belinger.edu', :property_id => 9, :password => 'password'}])
tenants  =Tenant.create([{:name =>'Kanye West', :phone_number =>'0594837261', :email =>'kanye@west.gov', :property_id => 11, :password => 'password'}])