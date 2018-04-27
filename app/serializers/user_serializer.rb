class UserSerializer < ActiveModel::Serializer
  attributes :id, :email

  has_many :projects
  has_many :messages
end
