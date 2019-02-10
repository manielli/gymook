FactoryBot.define do
  factory :user do
    first_name { "MyString" }
    last_name { "MyString" }
    email { "MyString" }
    password_digest { "MyString" }
    date_of_birth { "2019-02-09" }
    role { "MyString" }
    admin { false }
  end
end
