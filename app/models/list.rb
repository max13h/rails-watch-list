class List < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :movies, through: :bookmarks
  has_many :reviews, dependent: :destroy

  has_one_attached :banner

  validates :name, presence: true, uniqueness: true, length: { maximum: 15 }
  validates :banner, presence: false, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..(5.megabytes) }
end
