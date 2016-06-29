class CreateUserSubjects < ActiveRecord::Migration
  def change
    create_table :user_subjects do |t|
      t.integer :user_id
      t.integer :subject_id
      t.integer :user_course_id
      t.integer :course_id
      t.integer :status, default: 0
      t.timestamps null: false
    end
    add_index "user_subjects", ["subject_id"], name: "index_user_subjects_on_subject_id"
    add_index "user_subjects", ["user_id"], name: "index_user_subjects_on_user_id"
    add_index "user_subjects", ["user_course_id"], name: "index_user_subjects_on_user_course_id"
  end
end
