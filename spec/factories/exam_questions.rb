FactoryBot.define do
  factory :exam_question do
    question_id           { ["1"] }
    association :exam
    association :question
  end
end