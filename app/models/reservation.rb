class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :start_date, :end_date, presence: true
  validates :people_count, :price, :user_id, :room_id, presence: true, numericality: true
end
