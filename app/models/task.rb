class Task < ActiveRecord::Base
  belongs_to :project

  validates :title, :description, :status, presence: true

  enum status: [:active, :complete]
  scope :complete, -> {where(status: 1)}
  scope :active, -> {where(status: 0)}

  def active
    self.status == "active"
  end

  def complete
    self.status == "complete"
  end

  def tasks_complete?
    tasks.any? {|task| task.status == "active"} ? false : true
  end
end
