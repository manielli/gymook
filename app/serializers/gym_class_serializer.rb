class GymClassSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :class_type,
    :maximum_clients,
    :description,
    :cost,
    :created_at,
    :updated_at
  )

  belongs_to(:user, key: :creator_coach)
  has_many(:occurences)

  class OccurenceSerializer < ActiveModel::Serializer
    attributes(
      :id,
      :start_time,
      :end_time,
      :gym_class_id,
      :created_at,
      :updated_at,
    )

    belongs_to(:user, key: :creator_coach)
    has_many(:bookings)

    class BookingSerializer < ActiveMode::Serializer
      attributes(
        :id,
        :occurence_id,
        :user_id,
        :created_at,
        :updated_at
      )

      belongs_to(:user, key: :occurence_booker)
    end
  end
end
