FactoryBot.define do
  factory :gym_class do
    class_type { "MyString" }
    maximum_clients { 1 }
    description { "MyText" }
    cost { 1.5 }
  end
end
