class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.integer :status, default: 0
      t.timestamps null: false
    end
  end
end
