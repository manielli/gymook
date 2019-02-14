class Occurence < ApplicationRecord
  belongs_to :gym_class

  validates(
    :start_time,
    presence: true
  )

  validates(
    :end_time,
    presence: true
  )
end
