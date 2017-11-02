class Manager < ActiveRecord::Base
  has_many :properties, dependent: :destroy
  def self.create_with_omniauth(auth)
    Manager.create!(
      :provider => auth["provider"],
      :uid => auth["uid"],
      :name => auth["info"]["name"])
  end
end