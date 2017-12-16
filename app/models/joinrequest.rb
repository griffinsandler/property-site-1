#assigns the unique join request to the tenant, manager and property
class Joinrequest < ActiveRecord::Base
    belongs_to :manager
    belongs_to :tenant
    belongs_to :property
end
