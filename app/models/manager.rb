class Manager < ActiveRecord::Base
  has_many :properties, dependent: :destroy
  has_many :joinrequests
  has_many :services
  has_many :rents
  validates :email, :presence => true, :uniqueness => true
  def self.create_with_omniauth(auth)
    Manager.create!(
      :provider => auth["provider"],
      :uid => auth["uid"],
      :name => auth["info"]["name"],
      :email => auth["info"]["email"])
  end
end