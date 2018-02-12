class Tag < ActiveRecord::Base
  has_many :project_tags
  has_many :projects, through: :project_tags

  validates :name, presence: true, uniqueness: true
end
