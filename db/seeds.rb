# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

GymClass.destroy_all
User.destroy_all
Occurence.destroy_all
Booking.destroy_all

PASSWORD = "supersecret"

5.times do
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    
    User.create(
        first_name: first_name,
        last_name: last_name,
        email: "#{first_name.downcase}-#{last_name.downcase}@gymook.com",
        password: PASSWORD,
        date_of_birth: Faker::Date.birthday(25, 40).strftime("%Y-%m-%d"),
        role: "Coach"
    )
end

users = User.all

50.times do
    created_at = Faker::Date.backward(365 * 2)
    
    gc = GymClass.create(
        class_type: ["MuayHIIT", "MuayFit", "MuayThai", "Kickboxing", "Core Builder", "Zumba", "Yoga", "Spin", "Baré", "MMA", "Brazilian Jiu-Jitsu"].sample,
        maximum_clients: rand(10..15),
        description: Faker::Lorem.sentence(3, true, 3),
        cost: ["20","25","15"].sample,
        created_at: created_at,
        updated_at: created_at,
        user: users.sample
        )
        
    if gc.valid?
        rand(0..10).times do
            temp_time = Faker::Time.between_dates(from: Date.today, to: Date.today + 180, period: :evening)
            start_time = temp_time.strftime("%Y-%m-%d %H:00:00 -0800")
            end_time = temp_time.strftime("%Y-%m-%d #{(temp_time.strftime("%H").to_i+1).to_s}:00:00 -0800")

            gc.occurences << Occurence.new(
                start_time: start_time,
                end_time: end_time,
                user: users.sample,
                aasm_state: :active
            )
        end
    end
end


50.times do
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    
    user = User.create(
        first_name: first_name,
        last_name: last_name,
        email: "#{first_name.downcase}-#{last_name.downcase}@gymook.com",
        password: PASSWORD,
        date_of_birth: Faker::Date.birthday(18, 65).strftime("%Y-%m-%d"),
        role: "Client"
    )

    occurences = Occurence.all
    rand(0..25).times do
        occurence = occurences.sample
        
        occurence.bookings << Booking.new(
            user: user,
            aasm_state: :active
        )
    end
end

super_user = User.create(
    first_name: "Jon",
    last_name: "Snow",
    email: "js@winterfell.gov",
    password: "daenerystargaryen",
    date_of_birth: "1987-02-03",
    admin: true
)
