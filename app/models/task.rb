class Task < ActiveRecord::Base
  belongs_to :project

  validates :title, :description, :created_at, :completed_at, :status, :project_id, presence: true
end
