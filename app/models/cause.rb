class Cause < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :payments, dependent: :destroy

  has_one_attached :image

  validates :title, presence: true
  validates :description, presence: true
  validates :short_description, presence: true
  validates :goal_amount, presence: true, numericality: { greater_than: 0 }
  validates :start_date, presence: true
  validates :end_date, presence: true

  validates :image, presence: true, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..(5.megabytes) }

  VALID_STATUSES = %w[active completed]
  validates :status, inclusion: { in: VALID_STATUSES }, allow_nil: true

  def update_collected_amount(payment)
    if payment.status == "success"
      self.update(collected_amount: self.collected_amount.to_f + payment.amount)
    end
  end

  def donation_count
    payments.where(status: "success").count
  end  

  def ended?
    end_date < DateTime.now
  end 

end
