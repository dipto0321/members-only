FactoryBot.define do
  factory :comment_on_post, class: "Comment" do
    user_id User.first.id
    commentable_type "Post"
    commentable_id Post.first.id
    body Faker::Lorem.sentence
    created_at Time.now + 1000
  end
  
  factory :comment_on_comment, class: "Comment" do
    user_id User.first.id
    commentable_type "Comment"
    commentable_id Comment.first.id
    body Faker::Lorem.sentence
    created_at Time.now + 1200
  end
  
  factory :invalid_comment, class: "Comment" do
    user_id User.first.id
    commentable_type "Comment"
    commentable_id Comment.first.id
    body nil
    created_at Time.now + 1200
  end

end