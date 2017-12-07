class Tenant < ActiveRecord::Base
    belongs_to :property
    has_many :joinrequests, dependent: :destroy
    has_many :services, dependent: :destroy
    has_and_belongs_to_many :rent
    validates :name, :presence => true
end
