class DiaperChange < ApplicationRecord
  belongs_to :child
  belongs_to :caregiver

  enum :change_type, {
    wet: 0,
    solid: 1,
    both: 2,
    clean: 3
  }

  enum :color, {
    yellow: 0,
    brown: 1,
    green: 2,
    black: 3,
    red: 4
  }

  enum :consistency, {
    loose: 0,
    normal: 1,
    firm: 2
  }

  validates :time, presence: true
  validates :notes, length: { maximum: 65535 } # TEXT limit
  validate :consistency_required_for_solid

  private

  def consistency_required_for_solid
    if (solid? || both?) && consistency.nil?
      errors.add(:consistency, "must be specified for solid diaper changes")
    end
  end
end
