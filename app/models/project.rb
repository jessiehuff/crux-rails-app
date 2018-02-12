class Project < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :messages
  has_many :tasks
  has_many :project_tags
  has_many :tags, through: :project_tags

  validates :title, :content, presence: true

  def tag_names=(tags)
    tag_array = tags.split(",").map{|tag| tag.strip}
    tag_array.each do |tag|
      new_tag = Tag.find_or_create_by(name: tag)
      if self.tags.include?(new_tag)
        next
      end
      self.tags << new_tag
    end

  def tag_names
    tags = self.tags.collect {|tag| tag.name}
    tags.join(",")
  end

  def active_tasks
    self.tasks.active
  end

  def complete_tasks
    self.tasks.complete
  end

  def tasks_complete?
    tasks.any? {|task| task.status == "active"} ? false : true
  end
end
