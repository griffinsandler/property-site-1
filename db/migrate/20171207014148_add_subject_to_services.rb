class AddSubjectToServices < ActiveRecord::Migration
  def change
    add_column :services, :subject, :string
  end
end
