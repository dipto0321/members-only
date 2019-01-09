FactoryBot.define do
  
  factory :user do
    name Faker::Name.name
    email Faker::Internet.email
    password "password"
    password_confirmation "password"
  end

  factory :invalid_user, class: "User" do
    name nil
    email Faker::Internet.email
    password "password"
    password_confirmation "password"
  end

end