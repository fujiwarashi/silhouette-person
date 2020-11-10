class Exam < ApplicationRecord
  belongs_to :user
  has_many :results
  has_many :exam_questions
  has_many :questions, through: :exam_questions
end
