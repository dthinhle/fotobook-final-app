class Album < ApplicationRecord
  belongs_to :user
  has_many :photos, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :photos

  scope :public_albums, -> { where(private: false)}
  default_scope {order(created_at: :desc)}

  paginates_per 20

  validates :title, presence: true, length: { maximum: 140, too_long: "140 characters are maximum allowed!" }
  validates :desc, length: {maximum: 300, too_long: "300 characters are maximum allowed!" }
  validates :user_id, presence: true
end
