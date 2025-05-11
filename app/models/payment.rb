class Payment < ApplicationRecord
  belongs_to :cause

  validates :amount, presence: :true, numericality: { greater_than_or_equal_to: 10}

end