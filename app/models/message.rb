class Message < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  validates :content, presence: true
end
