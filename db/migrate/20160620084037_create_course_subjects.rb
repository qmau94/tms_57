class CreateCourseSubjects < ActiveRecord::Migration
  def change
    create_table :course_subjects do |t|
      t.integer :course_id
      t.integer :subject_id
      t.integer :status, default: 0
      t.timestamps null: false
    end
    add_index "course_subjects", ["course_id"], name: "index_course_subjects_on_course_id"
    add_index "course_subjects", ["subject_id"], name: "index_course_subjects_on_subject_id"
  end
end
