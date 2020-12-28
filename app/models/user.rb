class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable, :omniauthable, omniauth_providers: %i[github]

  validates :github_username, presence: true, uniqueness: { case_sensitive: false }

  # Want sign-up to authenticate with github_username (or email)

  attr_writer :login

  def login
    @login || self.github_username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(github_username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:github_username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.email = auth.info.email if auth.info.email.present?
      user.github_username = auth.info.nickname
      user.password = Devise.friendly_token[0, 20]
      # user.image = auth.info.image
      # user.skip_confirmation!
    end
  end
  
end
