class AddRentToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :rent, :integer
  end
end
