class Photo < ApplicationRecord
  belongs_to :imageable, polymorphic: true, optional: true

  validates :title, presence: true
  validates :desc, length: {maximum: 500}
  validates :imageable_type, exclusion: {in: %w"user album", message: "%{value} is invalid."}
end
