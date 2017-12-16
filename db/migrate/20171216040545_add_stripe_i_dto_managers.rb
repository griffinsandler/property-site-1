class AddStripeIDtoManagers < ActiveRecord::Migration
  def change
    add_column :managers, :stripe_user_id, :string
  end
end
