class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  paginates_per 20

  mount_uploader :avatar, AvatarUploader

  def name
    "#{self.first_name} #{self.last_name}"
  end

  has_many :notifications

  has_many :photos, as: :imageable
  has_many :albums

  validates :first_name, presence: true, length: { maximum: 25, too_long: "Your first name are too long, 25 characters are maximum allowed!" }
  validates :last_name, presence: true, length: { maximum: 25, too_long: "Your last name are too long, 25 characters are maximum allowed!" }
  validates :email, length: { maximum: 255, too_long: "Your email are too long, 255 characters are maximum allowed!" }

  has_many :follower_follows, foreign_key: :followee_id, dependent: :destroy, class_name: "Follow"
  has_many :followers, through: :follower_follows, source: :follower

  has_many :followee_follows, foreign_key: :follower_id, dependent: :destroy, class_name: "Follow"
  has_many :followees, through: :followee_follows, source: :followee
end
