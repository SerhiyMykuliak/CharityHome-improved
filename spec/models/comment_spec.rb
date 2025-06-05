# spec/models/comment_spec.rb
require 'rails_helper'

RSpec.describe Comment, type: :model do

  describe 'associations' do
    it { should belong_to(:cause) }
  end

  describe 'validations' do
    
    it { should validate_presence_of(:username) }
    it { should validate_length_of(:username).is_at_least(3).is_at_most(20) }
    it { should validate_presence_of(:email) }
    it { should allow_value('test@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email) }
    it { should validate_presence_of(:content) }
    it { should validate_length_of(:content).is_at_least(20).is_at_most(1000) }

  end
end
