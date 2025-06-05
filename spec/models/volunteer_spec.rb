require 'rails_helper'

RSpec.describe Volunteer, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_length_of(:first_name).is_at_most(50) }

    it { should validate_presence_of(:last_name) }
    it { should validate_length_of(:last_name).is_at_most(50) }

    it { should validate_presence_of(:email) }
    it { should allow_value('user@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email) }

    it { should validate_presence_of(:phone_number) }
    it { should allow_value('+1 555-123-4567').for(:phone_number) }
    it { should allow_value('(123) 456 7890').for(:phone_number) }
    it { should_not allow_value('abc123').for(:phone_number) }

    it { should validate_presence_of(:city) }
    it { should validate_length_of(:city).is_at_most(100) }

    it { should validate_presence_of(:description) }
    it { should have_one_attached(:avatar) }

    describe 'social media URLs' do
      it { should allow_value('https://facebook.com/user').for(:facebook_url) }
      it { should allow_value('http://instagram.com/user').for(:instagram_url) }
      it { should allow_value('https://twitter.com/user').for(:twitter_url) }

      it { should allow_value('').for(:facebook_url) }
      it { should allow_value(nil).for(:instagram_url) }

      it { should_not allow_value('ftp://facebook.com/user').for(:facebook_url) }
      it { should_not allow_value('invalid_url').for(:twitter_url) }
    end
  end
end
