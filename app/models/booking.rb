class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :occurence


  validates(
    :user_id,
    presence: true
  )
  validates(
    :occurence_id,
    uniqueness: {
      scope: :user_id,
      message: "You have already made a booking for this occurence!"
    }
  )

  include AASM

  aasm whiny_transitions: false do
    state :active, initial: true
    state :archived
    
    event :archive do
      transitions from: :active, to: :archived
    end

    event :activate do
      transitions from: :archived, to: :active
    end
  end

  def self.viewable
    where(aasm_state: [:active])
  end

  def self.archived
    where(aasm_state: [:archived])
  end

  scope(:recent, -> { order(created_at: :desc).limit(1000) })
end
