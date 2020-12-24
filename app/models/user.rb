class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  validates :github_username, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true, uniqueness: true

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
  
end
