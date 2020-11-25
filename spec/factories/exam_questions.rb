FactoryBot.define do
  factory :exam_question do
    association :exam
    association :question
  end
end