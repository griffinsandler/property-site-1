class AddIntRentToTenants < ActiveRecord::Migration
  def change
      add_column :tenants, :rentNum, :Integer
  end
end
