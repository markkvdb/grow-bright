class SleepSession < ApplicationRecord
  enum :location, {
    crib: 0,
    bed: 1,
    stroller: 2,
    car_seat: 3,
    carrier: 4,
    other: 5
  }

  belongs_to :child
  belongs_to :caregiver

  validates :start_time, presence: true
  validates :end_time, comparison: { greater_than: :start_time }, allow_nil: true
  validates :notes, length: { maximum: 65535 } # TEXT limit
end
