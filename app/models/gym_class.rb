class GymClass < ApplicationRecord
    belongs_to :user
    
    validates(
        :class_type,
        presence: true,
        uniqueness: true
    )

    validates(
        :description, 
        presence: true,
        length: {
            minimum: 10
        }
    )

    validates(
        :cost,
        presence: true,
        numericality: {
            greater_than_or_equal_to: 0
        }
    )
end
