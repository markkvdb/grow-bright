class ChildrenCaregiver < ApplicationRecord
  belongs_to :child
  belongs_to :caregiver

  validates :relationship, presence: true

  RELATIONSHIPS = [
    "parent",
    "grandparent",
    "nanny",
    "other"
  ].freeze

  validates :relationship, inclusion: { in: RELATIONSHIPS }
end
