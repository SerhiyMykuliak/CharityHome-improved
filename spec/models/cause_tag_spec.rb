require 'rails_helper'

RSpec.describe CauseTag, type: :model do
  describe 'associations' do
    it { should belong_to(:cause) } 
    it { should belong_to(:tag) } 
  end
end
