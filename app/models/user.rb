class User < ApplicationRecord

  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self

  validates_presence_of :name, :email

  has_and_belongs_to_many :addresses

  def jwt_payload
    self.jti = self.class.generate_jti
    self.save
    super.merge({
                  jti: self.jti,
                  usr: self.id,
                })
  end
end
