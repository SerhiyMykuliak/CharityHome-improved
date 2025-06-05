FactoryBot.define do
  factory :payment do
    association :cause
    amount { Faker::Commerce.price(range: 10..1000) }
    status { "pending" }
    username { Faker::Name.name }
    email { Faker::Internet.email }
    description { Faker::Lorem.sentence }
    reference { SecureRandom.hex(10) }
  end
end
