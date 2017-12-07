class AddDueDateToRent < ActiveRecord::Migration
  def change
    add_column :rents, :due, :date
  end
end
