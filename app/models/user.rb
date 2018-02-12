class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :projects
  has_many :messages

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
