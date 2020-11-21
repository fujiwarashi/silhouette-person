FactoryBot.define do
  factory :exam do
    title                 { Faker::Movie.title }
    message               { Faker::Quotes::Shakespeare.hamlet_quote }
    # question_ids          { 2 }
    association :user
  end
end
