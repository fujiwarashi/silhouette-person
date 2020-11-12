class Result < ApplicationRecord
  belongs_to :user
  belongs_to :exam
  has_many :result_choices
  has_many :choices, through: :result_choices
end
