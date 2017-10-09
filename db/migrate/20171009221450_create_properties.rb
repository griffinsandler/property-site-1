class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :name
      t.string :address
      t.decimal :square_feet
      t.integer :max_num_tenants
      t.integer :curr_num_tenants
      t.decimal :monthly_rent
      t.text :notes
      #t.belongs_to :manager, index :true
      #t.belongs_to :owner, index :true
      t.timestamps null: false
    end
  end
end
