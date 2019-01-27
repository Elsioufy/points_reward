FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email(name) }
    password { Faker::Internet.password 8,10 }
  end
end
