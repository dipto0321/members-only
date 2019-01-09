FactoryBot.define do
  factory :post do
    user_id User.first.id
    title "Example Post"
    content Faker::Lorem.sentence
    created_at Time.now
  end

end