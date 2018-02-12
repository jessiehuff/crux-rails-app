class Task < ActiveRecord::Base
  belongs_to :project

  validates :title, :description, :created_at, :completed_at, :status, :project_id, presence: true

  enum status: [:active, :complete]
  scope :complete, -> {where(status: 1)}
  scope :active, -> {where(status: 0)}

end
