class Caregiver < ApplicationRecord
  has_one :user
  has_many :children_caregivers
  has_many :children, through: :children_caregivers
  has_many :feedings

  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
