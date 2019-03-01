class UserSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :first_name,
    :last_name,
    :full_name,
    :email,
    :created_at,
    :updated_at,
    :role,
    :date_of_birth
  )

  # has_many(:bookings)
  # has_many(:occurences)
  # has_many(:gym_classes)
end
