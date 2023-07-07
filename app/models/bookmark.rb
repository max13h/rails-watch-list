class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list

  validates :movie, presence: true , uniqueness: { scope: :list }
  validates :list, presence: true
  validates :name, length: { minimum: 6 }

end