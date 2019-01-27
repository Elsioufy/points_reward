FactoryBot.define do
  factory :invitation do
    email { Faker::Internet.email }
    association :inviter_user, factory: :user
  end
end
