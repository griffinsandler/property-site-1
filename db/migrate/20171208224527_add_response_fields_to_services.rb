class AddResponseFieldsToServices < ActiveRecord::Migration
  def change
      add_column :services, :response, :string
      add_column :services, :resolved, :boolean
  end
end
