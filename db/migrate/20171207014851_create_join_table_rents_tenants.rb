class CreateJoinTableRentsTenants < ActiveRecord::Migration
  def change
    create_join_table :rents, :tenants do |t|
      t.index [:rent_id, :tenant_id]
      t.index [:tenant_id, :rent_id]
    end
  end
end
