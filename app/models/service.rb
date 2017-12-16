#services belong to tenant, managers, and property
class Service < ActiveRecord::Base
    belongs_to :manager
    belongs_to :tenant
    belongs_to :property
end
