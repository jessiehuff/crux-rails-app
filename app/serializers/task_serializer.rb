class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :assigned_to, :status

  belongs_to :project
end
