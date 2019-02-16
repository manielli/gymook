class Occurence < ApplicationRecord
  belongs_to :gym_class

  validate :start_time_must_not_be_in_the_past, on: :create
  validate :end_time_must_not_be_before_start_time, on: :create
  
  has_many :bookings, dependent: :destroy

  validates(
    :start_time,
    presence: true
  )

  validates(
    :end_time,
    presence: true
  )

  private
  def start_time_must_not_be_in_the_past
    if start_time.present? && start_time < DateTime.current
      errors.add(:start_time, "can not be in the past!")
    end
  end

  def end_time_must_not_be_before_start_time
    if start_time.present? && end_time.present? && end_time < start_time
      errors.add(:end_time, "can not be before the start time!")
    end
  end
end
