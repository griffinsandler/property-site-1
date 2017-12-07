class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.string :name
      t.string :phone_number
      t.string :email
      t.string :provider
      t.string :uid
      t.string :password
      t.belongs_to :property, true
      t.belongs_to :rent, true
      t.timestamps null: false
    end
  end
end

