class Activity < ApplicationRecord
  enum :activity_type, {
    tummy_time: 0,
    bath: 1,
    play: 2,
    walk: 3,
    massage: 4,
    other: 5
  }

  belongs_to :child
  belongs_to :caregiver

  validates :start_time, presence: true
  validates :end_time, comparison: { greater_than: :start_time }, allow_nil: true
  validates :milestone, inclusion: { in: [true, false] }
  validates :notes, length: { maximum: 65535 } # TEXT limit
end 