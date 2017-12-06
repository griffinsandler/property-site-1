class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.string :address
      t.string :room
      t.string :notes
      t.belongs_to :tenant, index: true
      t.belongs_to :property, index: true
      t.belongs_to :manager, index: true
      t.timestamps null: false
    end
  end
end
