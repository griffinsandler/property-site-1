class AddRenttoTenants < ActiveRecord::Migration
  def change
    add_column :tenants, :rent, :integer
  end
end
