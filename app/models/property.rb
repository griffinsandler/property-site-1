class Property < ActiveRecord::Base
      belongs_to :manager
      has_many :tenants
      has_many :joinrequests
      validates :name, :presence => true
      validates :address, :presence => true
      validates :square_feet, :presence => true
      validates :max_num_tenants, :presence => true
      validates :curr_num_tenants, :presence => true
      validates :monthly_rent, :presence => true
end
