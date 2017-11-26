class Tenant < ActiveRecord::Base
    belongs_to :property
    has_many :joinrequests, dependent: :destroy
    validates :name, :presence => true
end
