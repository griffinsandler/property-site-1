class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.string :name
      t.has_one :property, index: true
  
      t.timestamps null: false
    end
  end
end
