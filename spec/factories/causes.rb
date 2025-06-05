FactoryBot.define do
  factory :cause do
    title { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph(sentence_count: 3) }
    short_description { Faker::Lorem.sentence(word_count: 6) }
    goal_amount { Faker::Number.decimal(l_digits: 4, r_digits: 2) } 
    collected_amount { Faker::Number.decimal(l_digits: 3, r_digits: 2) } 
    status { "active" } 
    start_date { Faker::Date.backward(days: 10) }
    end_date { Faker::Date.forward(days: 30) }

    after(:build) do |cause|
      cause.image.attach(
        io: File.open(Rails.root.join('spec/fixtures/files/sample.jpg')),
        filename: 'sample.jpg',
        content_type: 'image/jpeg'
      )
    end
  end
end

