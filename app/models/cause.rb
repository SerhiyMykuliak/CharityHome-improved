class Cause < ApplicationRecord
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :payments, dependent: :destroy

  def update_collected_amount(payment)
    if payment.status == "success"
      self.update(collected_amount: self.collected_amount.to_f + payment.amount)
    end
  end

end
