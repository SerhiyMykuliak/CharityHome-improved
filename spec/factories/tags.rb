FactoryBot.define do
  factory :tag do
    sequence(:name) { Faker::Lorem.sentence(word_count: 2) }
  end
end
