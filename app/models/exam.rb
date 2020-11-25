class Exam < ApplicationRecord
  belongs_to :user
  has_many :results, dependent: :destroy
  has_many :exam_questions , dependent: :destroy
  has_many :questions, through: :exam_questions

  with_options presence: true do
    validates :title
    validates :message
    validates :question_ids
  end
  

  after_save :create_id_digest

  def to_param
    id_digest
  end

  private
  
  def create_id_digest
    if id_digest.nil?
      new_digest = Digest::MD5.hexdigest(id.to_s)
      update_column(:id_digest, new_digest)
    end
  end
end