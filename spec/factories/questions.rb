FactoryBot.define do
  factory :question do
    content               { Faker::Movie.title }
    allocation_id         { Faker::Number.between(from: 1, to: 50) }
    association :user
    # association :exam
  end
end
