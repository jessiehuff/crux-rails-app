class Task < ActiveRecord::Base
  belongs_to :project

  validates :title, :description, :status, presence: true

  enum status: [:active, :complete]
  scope :complete, -> {where(status: 1)}
  scope :active, -> {where(status: 0)}

end
