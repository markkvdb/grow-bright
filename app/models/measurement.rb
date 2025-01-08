class Measurement < ApplicationRecord
  belongs_to :child
  belongs_to :caregiver

  measured_weight :weight
  measured_length :length
  measured_length :head_circumference

  validates :date, presence: true
  validates :weight, measured: { greater_than: 0.0 }
  validates :length, measured: { greater_than: 0.0 }
  validates :head_circumference, measured: { greater_than: 0.0 }
  validates :notes, length: { maximum: 65535 } # TEXT limit

  before_validation :set_default_units

  private

  def set_default_units
    self.weight_unit ||= 'kg'
    self.length_unit ||= 'cm'
    self.head_circumference_unit ||= 'cm'
  end
end 