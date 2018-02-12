class Project < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :messages
  has_many :tasks
  has_many :project_tags
  has_many :tags, through: :project_tags

  validates :title, :content, presence: true
end
