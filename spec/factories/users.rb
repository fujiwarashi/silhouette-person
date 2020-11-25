FactoryBot.define do
  factory :user do
    email                 {Faker::Internet.free_email}
    name                  {Faker::Name.initials(number: 2)}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
  end
end