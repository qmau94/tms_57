class CreateUserTasks < ActiveRecord::Migration
  def change
    create_table :user_tasks do |t|
      t.integer :task_id
      t.integer :user_id
      t.string :status	
      t.timestamps null: false
    end
    add_index "user_tasks", ["task_id"], name: "index_user_tasks_on_task_id"
    add_index "user_tasks", ["user_id"], name: "index_user_tasks_on_user_id"
  end
end
