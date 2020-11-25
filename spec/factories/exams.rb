FactoryBot.define do
  factory :exam do
    title                 { Faker::Movie.title }
    message               { Faker::Quotes::Shakespeare.hamlet_quote }
    status                {"2"}
    association :user
    # association :question

    # question_ids          { "1" }

    # association :question

    # "question_ids"=>["8"]
  end
end
