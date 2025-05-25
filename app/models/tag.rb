class Tag < ApplicationRecord
  has_many :cause_tags, dependent: :destroy
  has_many :causes, through: :cause_tags

end
