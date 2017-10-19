class CreateLandlords < ActiveRecord::Migration
  def change
    create_table :landlords do |t|
    t.string :first_name
    t.string :last_name
    t.string :office_address
    t.string :phone_number
    t.string :email
    t.text :notes
    t.timestamps null: false
    end
  end
end
