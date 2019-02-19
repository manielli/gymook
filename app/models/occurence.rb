class Occurence < ApplicationRecord
  belongs_to :gym_class
  belongs_to :user

  has_many :bookers, through: :bookings, source: :user
  has_many :bookings, dependent: :destroy

  validate :start_time_must_not_be_in_the_past, on: :create
  validate :end_time_must_not_be_before_start_time, on: :create
  
  validates(
    :start_time,
    presence: true
  )

  validates(
    :end_time,
    presence: true
  )

  include AASM

  aasm whiny_transitions: false do
    state :active, initial: true
    state :archived
    
    event :archive do
      transitions from: :active, to: :archived
    end
    event :activate do
      transitions from: :archive, to: :active
    end
  end

  def self.viewable
    # self
    #   .where(aasm_state: [:active])
    #   .each { |occurence|
    #   occurence.start_time < DateTime.current ? occurence.update(aasm_state: :archived) : nil
    #   }

    self.where(aasm_state: [:active])
  end

  def self.archived
    where(aasm_state: [:archived])
  end

  scope(:recent, -> { order(created_at: :desc).limit(1000) })

  private
  def start_time_must_not_be_in_the_past
    if start_time.present? && start_time < DateTime.current
      errors.add(:start_time, "can not be in the past!")
    end
  end

  def end_time_must_not_be_before_start_time
    if start_time.present? && end_time.present? && end_time <= start_time
      errors.add(:end_time, "can not be before the start time!")
    end
  end
end
