#rent belogs to a property and manager but can have many tenants 
class Rent < ActiveRecord::Base
    belongs_to :property
    belongs_to :manager
    has_and_belongs_to_many :tenants
end
