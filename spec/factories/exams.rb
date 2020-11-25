FactoryBot.define do
  factory :exam do
    title                 { Faker::Movie.title }
    message               { Faker::Quotes::Shakespeare.hamlet_quote }
    status                {"2"}
    question_ids          {"1"}
    association :user
  end
end
