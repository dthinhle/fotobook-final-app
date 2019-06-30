class Album < ApplicationRecord
  belongs_to :user
  has_many :photos, as: :imageable
  accepts_nested_attributes_for :photos

  validates :title, presence: true
  validates :desc, length: {maximum: 500}
  validates :user_id, presence: true
end
