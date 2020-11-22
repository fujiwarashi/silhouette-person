class Question < ApplicationRecord
  has_one_attached :image, dependent: :destroy

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :allocation

  belongs_to :user
  has_many :choices, dependent: :destroy
  has_many :exam_questions, dependent: :destroy
  has_many :exams, through: :exam_questions
  
end