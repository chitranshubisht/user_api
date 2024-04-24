FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password_digest { Faker::Internet.password(min_length: 8) }
  end
end