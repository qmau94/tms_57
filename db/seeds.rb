# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create! name: "Admin", email: "admin@gmail.com",
  password: "1", password_confirmation: "1", role: 1
User.create! name: "User", email: "user@gmail.com",
  password: "1", password_confirmation: "1", role: 0

50.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@gmail.com"
  password = "1"
  User.create! name: name, email: email, password: password,
    password_confirmation: password, role: 0
end

users = User.all
user  = users.first
following = users[2..40]
followers = users[3..30]
following.each {|followed| user.follow followed}
followers.each {|follower| follower.follow user}

10.times do |s|
  name = Faker::App.name
  description = Faker::Lorem.sentence
  Subject.create! name: name, description: description,
  tasks_attributes: [
    {name:"Lesson 1", description: "lesson 1"},
    {name:"Lesson 2", description: "lesson 2"},
    {name:"Lesson 3", description: "lesson 3"},]
end

Course.create! name: "Web Development", description: "How to make a web app",
  subject_ids: ["1","2"]
Course.create! name: "App Development", description: "Flappy",
  subject_ids: ["4","7"]

UserCourse.create! user_id: 2, course_id: 1
UserCourse.create! user_id: 3, course_id: 1
UserCourse.create! user_id: 4, course_id: 1
