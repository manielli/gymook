class GymClass < ApplicationRecord
    belongs_to :user

    has_many :occurences, dependent: :destroy

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
        :maximum_clients,
        presence: true,
        numericality: {
            greater_than_or_equal_to: 0
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
