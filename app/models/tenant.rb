class Tenant < ActiveRecord::Base
    has_one :property
end
