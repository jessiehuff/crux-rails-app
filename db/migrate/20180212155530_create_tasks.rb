class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.string :assigned_to
      t.datetime :created_at
      t.datetime :completed_at
      t.integer :status, default: 0
      t.integer :project_id

      t.timestamps null: false
    end
  end
end
