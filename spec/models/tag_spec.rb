require 'rails_helper'

RSpec.describe Tag, type: :model do

  describe 'associations' do
    it { should have_many(:cause_tags).dependent(:destroy) }
    it { should have_many(:causes).through(:cause_tags) }
  end

  describe 'validation' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
