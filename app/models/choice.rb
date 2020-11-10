class Choice < ApplicationRecord
  belongs_to :question
  has_many :result_choices
  has_many :results, through: :result_choices
end
