class List < ApplicationRecord
  has_many :movies, through: :bookmarks
  has_many :bookmarks, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
