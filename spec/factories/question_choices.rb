FactoryBot.define do
  factory :question_choice do
    content               { Faker::Movie.title }
    allocation_id         { Faker::Number.between(from: 1, to: 50) }
    text                  { Faker::Movie.title }
    answer_id             { Faker::Number.between(from: 1, to: 2) }
    # association :user
    # association :question
  end
end
