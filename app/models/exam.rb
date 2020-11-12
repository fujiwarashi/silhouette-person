class Exam < ApplicationRecord
  belongs_to :user
  has_many :results, dependent: :destroy
  has_many :exam_questions , dependent: :destroy
  has_many :questions, through: :exam_questions

  with_options presence: true do
    validates :title
    validates :message
  end
end
