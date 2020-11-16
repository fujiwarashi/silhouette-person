class Result < ApplicationRecord
  belongs_to :user
  belongs_to :exam
  has_many :result_choices, dependent: :destroy
  has_many :choices, through: :result_choices

  validates :choice_ids, presence: true
end
