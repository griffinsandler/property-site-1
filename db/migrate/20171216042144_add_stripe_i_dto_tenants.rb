class AddStripeIDtoTenants < ActiveRecord::Migration
  def change
        add_column :tenants, :stripe_user_id, :string
  end
end
