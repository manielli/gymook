# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

GymClass.destroy_all

10.times do
    created_at = Faker::Date.backward(365 * 2)

    gc = GymClass.create(
        class_type: ["MuayHIIT", "MuayFit", "MuayThai", "Kickboxing", "Core Builder"].sample,
        maximum_clients: rand(1..15),
        description: Faker::Lorem.sentences(1, true),
        cost: ["20","25","15"].sample,
        created_at: created_at,
        updated_at: created_at
    )
end
