class Tenant < ActiveRecord::Base
    #tenant can only belong to one property 
    belongs_to :property
    has_many :joinrequests, dependent: :destroy
    has_many :services, dependent: :destroy
    has_and_belongs_to_many :rent
    validates :name, :presence => true
    validates :email, :presence => true, :uniqueness => true
    def self.create_with_omniauth(auth)
    Tenant.create!(
      :provider => auth["provider"],
      :uid => auth["uid"],
      :name => auth["info"]["name"],
      :email => auth["info"]["email"],
      :phone_number => auth["info"]["phone"])
  end
end
