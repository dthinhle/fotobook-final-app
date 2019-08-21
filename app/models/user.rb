class User < ApplicationRecord
  include LetterAvatar::AvatarHelper
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

  def avt_url
    unless self.avatar.url.nil?
      return self.avatar.url
    else
      return letter_avatar_url(self.name, 256)
    end
  end

  has_many :notifications, dependent: :destroy

  has_many :photos, as: :imageable, dependent: :destroy
  has_many :albums, dependent: :destroy

  validates :first_name, presence: true, length: { maximum: 25, too_long: "Your first name are too long, 25 characters are maximum allowed!" }
  validates :last_name, presence: true, length: { maximum: 25, too_long: "Your last name are too long, 25 characters are maximum allowed!" }
  validates :email, length: { maximum: 255, too_long: "Your email are too long, 255 characters are maximum allowed!" }

  has_many :follower_follows, foreign_key: :followee_id, dependent: :destroy, class_name: "Follow"
  has_many :followers, through: :follower_follows, source: :follower

  has_many :followee_follows, foreign_key: :follower_id, dependent: :destroy, class_name: "Follow"
  has_many :followees, through: :followee_follows, source: :followee
end
