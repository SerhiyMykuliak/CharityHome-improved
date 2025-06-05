FactoryBot.define do
  factory :gallery_image do
    title { Faker::Lorem.characters(number: 10) }

    after(:build) do |gallery_image|
      gallery_image.image.attach(
        io: File.open(Rails.root.join('spec/fixtures/files/sample.jpg')),
        filename: 'sample.jpg',
        content_type: 'image/jpeg'
      )
    end
  end
end
