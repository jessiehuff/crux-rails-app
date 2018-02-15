class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_and_belongs_to_many :projects
  has_many :messages

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth[:info][:email]
      user.password = Devise.friendly_token[0,20]
    end
  end

  def self.new_with_sessions(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def all_projects
    self.projects
  end

  def self.new_with_email_error
    self.new do |u|
      u.errors.add(:email, :not_found, message: "not found in existing users.")
    end
  end

  def password_error
    self.errors.add(:password, :incorrect, message: "is incorrect for the email provided.")
  end
end
