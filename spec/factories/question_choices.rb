FactoryBot.define do
  factory :question_choice do
    content               { Faker::Movie.title }
    allocation_id         { Faker::Number.between(from: 1, to: 50) }
    text                  { [{ tex: Faker::Movie.title}, { tex: Faker::Movie.title}, { tex: Faker::Movie.title}, { tex: Faker::Movie.title}] }
    answer_id             { [{"ans"=>"2"}, {"ans"=>"2"}, {"ans"=>"2"}, {"ans"=>"2"}] }
  end
end
