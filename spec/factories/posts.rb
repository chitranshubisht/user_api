FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
  end
end