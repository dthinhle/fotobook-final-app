class Album < ApplicationRecord
  belongs_to :user
  has_many :photos, as: :imageable
  accepts_nested_attributes_for :photos
end
