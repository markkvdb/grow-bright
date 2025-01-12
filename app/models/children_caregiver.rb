class ChildrenCaregiver < ApplicationRecord
  belongs_to :child
  belongs_to :caregiver

  enum :relationship, {
    parent: "parent",
    grandparent: "grandparent",
    nanny: "nanny",
    other: "other"
  }
  validates :relationship, presence: true
end
