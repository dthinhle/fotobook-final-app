class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :avatar, AvatarUploader

  has_many :photos, as: :imageable
  has_many :albums

  validates :first_name, :last_name, presence: true, length: { maximum: 25, too_long: "25 characters are maximum allowed!" }
  validates :email, length: { maximum: 255, too_long: "255 characters are maximum allowed!" }

  has_many :follower_follows, foreign_key: :followee_id, class_name: "Follow"
  has_many :followers, through: :follower_follows, source: :follower

  has_many :followee_follows, foreign_key: :follower_id, class_name: "Follow"
  has_many :followees, through: :followee_follows, source: :followee
end
