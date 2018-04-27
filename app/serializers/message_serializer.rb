class MessageSerializer < ActiveModel::Serializer
  attributes :id, :title, :content

  belongs_to :project
  belongs_to :user
end
