class Booking < ApplicationRecord
  belongs_to :occurence
  belongs_to :user

end
