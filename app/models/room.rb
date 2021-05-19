class Room < ApplicationRecord
  belongs_to :user 
  has_many :reservations

  validates :name, :description, :address, presence: true
  validates :price, :user_id, presence: true, numericality: true

  mount_uploader :image, ImageUploader
end
