FactoryBot.define do
  factory :volunteer do
    first_name { Faker::Name.first_name[0..49] }
    last_name  { Faker::Name.last_name[0..49] }
    email { Faker::Internet.unique.email }
    phone_number { '+1 (555) 123-4567' }
    city { Faker::Address.city[0..99] }
    description { Faker::Lorem.sentence(word_count: 20)[0..999] }
    facebook_url { "https://facebook.com/#{Faker::Internet.username(specifier: 5..10)}" }
    instagram_url { "https://instagram.com/#{Faker::Internet.username(specifier: 5..10)}" }
    twitter_url { "https://twitter.com/#{Faker::Internet.username(specifier: 5..10)}" }

    after(:build) do |volunteer|
      volunteer.avatar.attach(
        io: File.open(Rails.root.join('spec/fixtures/files/sample.jpg')),
        filename: 'sample.jpg',
        content_type: 'image/jpeg'
      )
    end
  end
end
