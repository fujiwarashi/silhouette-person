class Choice < ApplicationRecord
  belongs_to :question
  has_many :result_choices, dependent: :destroy
  has_many :results, through: :result_choices
end
