class Album < ApplicationRecord
  belongs_to :user
  has_many :photos, as: :imageable
  accepts_nested_attributes_for :photos

  validates :title, presence: true, length: { maximum: 140, too_long: "140 characters are maximum allowed!" }
  validates :desc, length: {maximum: 300, too_long: "300 characters are maximum allowed!" }
  validates :user_id, presence: true
end
