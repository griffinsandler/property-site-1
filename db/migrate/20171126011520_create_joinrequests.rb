class CreateJoinrequests < ActiveRecord::Migration
  def change
    drop_table(:joinrequests)
    create_table :joinrequests do |t|
      t.boolean :resolved
      t.belongs_to :tenant, index: true
      t.belongs_to :property, index: true
      t.belongs_to :manager, index: true
      t.timestamps null: false
    end
  end
end
