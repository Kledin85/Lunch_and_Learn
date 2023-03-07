FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.first_name}
    api_key { Faker::Number.number(digits: 10)}
  end
end