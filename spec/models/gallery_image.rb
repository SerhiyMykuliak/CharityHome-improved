# spec/models/gallery_image_spec.rb
require 'rails_helper'

RSpec.describe GalleryImage, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_least(5).is_at_most(30) }
    it { should have_one_attached(:image) }
  end
end
