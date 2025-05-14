class GalleryImage < ApplicationRecord
  has_one_attached :image

  validates :title, presence: true, length: {minimum:5, maximum:30}
  validates :image, presence: true, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..(5.megabytes) }
end
