class Caregiver < ApplicationRecord
  has_many :children_caregivers
  has_many :children, through: :children_caregivers
  has_many :feedings

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def full_name
    "#{first_name} #{last_name}"
  end
end
