class Child < ApplicationRecord
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_fill: [ 40, 40 ]
    attachable.variant :medium, resize_to_fill: [ 96, 96 ]
  end

  has_many :children_caregivers, dependent: :destroy
  has_many :caregivers, through: :children_caregivers

  has_many :feedings, dependent: :destroy
  has_many :diaper_changes, dependent: :destroy
  has_many :sleep_sessions, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :measurements, dependent: :destroy

  measured_weight :birth_weight
  measured_length :birth_length

  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, length: { maximum: 255 }, allow_nil: true
  validates :birth_date, presence: true
  validates :birth_weight, measured: { greater_than: 0.0 }, allow_nil: true
  validates :birth_length, measured: { greater_than: 0.0 }, allow_nil: true

  accepts_nested_attributes_for :children_caregivers, 
    allow_destroy: true,
    reject_if: proc { |attributes| attributes['caregiver_id'].blank? }

  def age
    ((Time.zone.now - birth_date.to_time) / 1.year.seconds).floor
  end

  def age_in_months
    ((Time.zone.now - birth_date.to_time) / 1.month.seconds).floor
  end
end
