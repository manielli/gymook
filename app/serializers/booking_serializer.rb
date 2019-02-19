class BookingSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :occurence_id,
    :user_id,
    :created_at,
    :updated_at
  )

  belongs_to(:user, key: :occurence_booker)
end
