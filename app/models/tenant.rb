class Tenant < ActiveRecord::Base
    belongs_to :property
    validates :first_name, :presence => true,
end
