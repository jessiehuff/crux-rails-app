class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :title, :description

  has_many :users
  has_many :messages
  has_many :tasks
  has_many :project_tags
  has_many :tags, through: :project_tags
end
