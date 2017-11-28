class AddRentToTenants < ActiveRecord::Migration
  def change
    add_column :tenants, :rent, :string
  end
end
