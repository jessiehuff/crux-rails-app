class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description

  belongs_to :project
end
