class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :occurence

  validates(
    :user_id,
    presence: true,
    uniqueness: {
      scope: :occurence_id,
      message: "An occurence already has a booking for this user!"
    }
  )
  validates(
    :occurence_id,
    uniqueness: {
      scope: :user_id,
      message: "You have already made a booking for this occurence!"
    }
  )
end
