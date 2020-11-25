FactoryBot.define do
  factory :question do
    id                    {1}
    content               { Faker::Movie.title }
    allocation_id         { Faker::Number.between(from: 1, to: 50) }
    association :user
  end
end
