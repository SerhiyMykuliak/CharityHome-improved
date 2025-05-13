class Volunteer < ApplicationRecord
  has_one_attached :avatar

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :avatar, presence: true, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..(5.megabytes) }
  validates :city, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 1000 }

  VALID_PHONE_REGEX = /\A[\d\s\-\+\(\)]+\z/
  validates :phone_number, presence: true, format: { with: VALID_PHONE_REGEX }

  validates :facebook_url, :instagram_url, :twitter_url,
            format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }, 
            allow_blank: true
  
end
