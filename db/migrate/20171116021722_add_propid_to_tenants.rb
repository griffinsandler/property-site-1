class AddPropidToTenants < ActiveRecord::Migration
  def change
    add_column :tenants, :property_id, :integer
  end
end
