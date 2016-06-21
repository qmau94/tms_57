class CreateUserCourses < ActiveRecord::Migration
  def change
    create_table :user_courses do |t|
      t.integer :user_id
      t.integer :course_id
      t.timestamps null: false
    end
    add_index "user_courses", ["course_id"], name: "index_user_courses_on_course_id"
    add_index "user_courses", ["user_id"], name: "index_user_courses_on_user_id"
  end
end
