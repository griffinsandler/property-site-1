class CreateRents < ActiveRecord::Migration
  def change
    create_table :rents do |t|
      t.integer :total
      t.belongs_to :property, index: true
      t.belongs_to :manager, index: true
      t.timestamps null: false
    end
  end
end
