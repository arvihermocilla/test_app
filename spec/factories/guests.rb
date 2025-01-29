
FactoryBot.define do
  factory :guest do
    first_name   { Faker::Name.first_name }
    last_name    { Faker::Name.last_name }
    email        { Faker::Internet.email }
    phone_number { [ Faker::Number.between(from: 630_000_000_000, to: 639_999_999_999) ] }
  end
end
