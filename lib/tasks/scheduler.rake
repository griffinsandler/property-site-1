task :create_new_rents => :environment do
    time = Time.now
    if time.day == 1
        @properties = Property.all
        @properties.each do |p|
            @rent = Rent.new
            @rent.property_id = p.id
            @rent.manager_id = p.manager_id
            @rent.total = p.rent
            @tenants = Tenants.where(:property_id => p.id)
            @rent.due = time + 1.month
            @rent.save
            @tenants.each do |t|
                t.rents << @rent
                @rent.tenants << t
                @t.save
            end
            @rent.save
        end
    end
end