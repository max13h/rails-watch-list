class Movie < ApplicationRecord
  has_many :lists, through: :bookmarks
  has_many :bookmarks

  validates :title, presence: true, uniqueness: true
  validates :overview, presence: true

  before_destroy :check_presence

  private

  def check_presence
    if bookmarks.exists?
      errors.add(:base, message: "Cannot delete the movie because it is referenced in bookmarks.")
      throw :abort
    end
  end
end
