class User < ApplicationRecord
    has_many :gym_classes, dependent: :nullify
    has_many :occurences, dependent: :nullify

    has_many :bookings, dependent: :destroy
    has_many :booked_occurences, through: :bookings, source: :occurence
    
    validate :date_of_birth_must_not_be_a_future_date, on: [:create]
    
    has_secure_password

    validates(
        :first_name,
        presence: true
    )

    validates(
        :last_name,
        presence: true
    )

    validates(
        :email,
        presence: true,
        uniqueness: true,
        format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    )

    validates(
        :date_of_birth,
        presence: true
    )

    def self.search search_term
        self.where("first_name ILIKE ?", "#{search_term}") ||
        self.where("last_name ILIKE ?", "#{search_term}") ||
        self.where("email ILIKE ?", "#{search_term}")
    end

    def full_name
        "#{first_name} #{last_name}".strip
    end

    private
    def date_of_birth_must_not_be_a_future_date
        if date_of_birth.present? && date_of_birth >= Time.zone.today
            errors.add(:date_of_birth, "must not be today or in the future")
        end
    end
end
