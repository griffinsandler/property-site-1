class Rent < ActiveRecord::Base
    belongs_to :property
    belongs_to :manager
    has_and_belongs_to_many :tenants
end
