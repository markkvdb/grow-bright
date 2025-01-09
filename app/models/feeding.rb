class Feeding < ApplicationRecord
  belongs_to :child
  belongs_to :caregiver

  enum :feeding_type, {
    breast: 0,
    bottle: 1,
    solid: 2
  }

  enum :side, {
    left: 0,
    right: 1,
    both: 2
  }

  measured_volume :volume, unit_field_name: :volume_unit
  measured_weight :weight, unit_field_name: :weight_unit

  validates :start_time, presence: true
  validates :end_time, comparison: { greater_than: :start_time }, presence: true
  validates :volume, measured: { greater_than: 0 }, presence: true, if: :bottle?
  validates :weight, measured: { greater_than: 0 }, presence: true, if: :solid?
  validates :side, presence: true, if: :breast?
  validates :notes, length: { maximum: 65535 }

  def amount
    if bottle?
      volume
    elsif solid?
      weight
    end
  end

  def duration_minutes
    return nil unless start_time && end_time
    ((end_time - start_time) / 60).round
  end
end
