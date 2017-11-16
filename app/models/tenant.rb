class Tenant < ActiveRecord::Base
    belongs_to :property
    validates :name, :presence => true
end
