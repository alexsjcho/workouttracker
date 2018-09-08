class User < ApplicationRecord
  extend Devise::Models
  # Include default devise modules. Others available are:
after_create :create_tenant
after_destroy :delete_tenant
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, request_keys:[:subdomain]

  validates :email, uniqueness:true
  has_many :workouts, dependent: :destroy

  def create_tenant
    Apartment::Tenant.create(subdomain)
  end

  def delete_tenant
    Apartment::Tenant.drop(subdomain)
  end

def self.find_for_authentication(warden_conditions)
  where(email:warden_conditions[:email],subdomain:warden_conditions[:subdomain]).first
end

end

  def self.from_omniauth(auth)
    # Either create a User record or update it based on the provider (Google) and the UID
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.token = auth.credentials.token
      user.expires = auth.credentials.expires
      user.expires_at = auth.credentials.expires_at
      user.refresh_token = auth.credentials.refresh_token
    end
  end
