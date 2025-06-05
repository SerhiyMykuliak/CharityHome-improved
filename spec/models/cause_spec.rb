require 'rails_helper'

RSpec.describe Cause, type: :model do

  describe 'associations' do
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:payments).dependent(:destroy) }
    it { should have_many(:cause_tags).dependent(:destroy) }
    it { should have_many(:tags).through(:cause_tags) }
    it { should have_one_attached(:image) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:short_description) }
    it { should validate_presence_of(:goal_amount) }
    it { should validate_numericality_of(:goal_amount).is_greater_than(0) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_inclusion_of(:status).in_array(%w[active completed]) }

  end

  describe '#update_collected_amount' do
    let(:cause) { create(:cause, collected_amount: 100.0) }
    let(:payment_success) { build(:payment, amount: 50.0, status: 'success', cause: cause) }
    let(:payment_pending) { build(:payment, amount: 50.0, status: 'pending', cause: cause) }

    it 'updates collected_amount when payment status is success' do
      expect {
        cause.update_collected_amount(payment_success)
      }.to change { cause.reload.collected_amount }.by(50.0)
    end

    it 'does not update collected_amount when payment status is not success' do
      expect {
        cause.update_collected_amount(payment_pending)
      }.not_to change { cause.reload.collected_amount }
    end
  end

  describe '#donation_count' do
    let(:cause) { create(:cause) }
    before do
      create_list(:payment, 3, cause: cause, status: 'success')
      create_list(:payment, 2, cause: cause, status: 'pending')
    end

    it 'returns count of payments with status success' do
      expect(cause.donation_count).to eq(3)
    end
  end

  describe '#ended?' do
    it 'returns true if end_date is in the past' do
      cause = build(:cause, end_date: 1.day.ago)
      expect(cause.ended?).to be true
    end

    it 'returns false if end_date is in the future' do
      cause = build(:cause, end_date: 1.day.from_now)
      expect(cause.ended?).to be false
    end
  end
end
