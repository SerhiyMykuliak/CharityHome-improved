class Comment < ApplicationRecord
  belongs_to :cause

  validates :username, presence: :true, length: {minimum:3, maximum:20}
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :content, presence: true, length: {minimum:20, maximum:1000}

end
