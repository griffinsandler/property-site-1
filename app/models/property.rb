class Property < ActiveRecord::Base
    #every property belongs to a manager
    belongs_to :manager
    #multiple people live in properties
    has_many :tenants
    has_many :joinrequests
    has_many :services
    #creates validation requirements 
    validates :name, :presence => true
    validates :address, :presence => true
    validates :square_feet, :presence => true
    validates :max_num_tenants, :presence => true
    validates :curr_num_tenants, :presence => true
    validates :monthly_rent, :presence => true
end
