class AddManagerIdToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :manager_id, :integer
  end
end
