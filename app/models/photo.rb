class Photo < ApplicationRecord
  belongs_to :imageable, polymorphic: true, optional: true

  validates :title, presence: true, length: { maximum: 140, too_long: "140 characters are maximum allowed!" }
  validates :desc, length: {maximum: 300, too_long: "300 characters are maximum allowed!" }
  validates :imageable_type, inclusion: {in: %w"User Album", message: "%{value} is invalid."}
end
