class Question < ApplicationRecord
  belongs_to :user
  has_many :choices
  has_many :exam_questions
  has_many :exams, through: :exam_questions
  has_one_attached :image
end