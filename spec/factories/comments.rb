FactoryBot.define do
  factory :comment do
    association :cause
    username { Faker::Internet.username(specifier: 3..20) }
    email { Faker::Internet.email }
    content { Faker::Lorem.paragraph_by_chars(number: 100, supplemental: false) }
  end
end
