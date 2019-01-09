# frozen_string_literal: true
def username_generator(fullname)
  (fullname.split(' ')[0] + (0..9).to_a.sample(4).join).downcase
end
30.times do
  name = Faker::Name.name
  email =  "#{username_generator(name)}@demomail.com"
  password = 'password'
  password_confirmation = 'password'
  User.create!(name: name, email: email, password: password, password_confirmation: password_confirmation)
end

users = User.take(10)

20.times do
  user_id = rand(User.first.id..User.last.id)
  title = Faker::Lorem.sentence(4)
  content = Faker::Lorem.paragraphs(5)
  users.each { |user| user.posts.create!(title: title, content: content) }
end

20.times do
  commentable_id = rand(Post.first.id..Post.last.id)
  commentable_type = "Post"
  body = Faker::Lorem.sentence(2)
  users.each {|user| user.comments.create(commentable_id: commentable_id, commentable_type: commentable_type, body: body)}
end

User.first.comments.create(commentable_id: Post.last.id, commentable_type:"Post",body:Faker::Lorem.sentence(2))