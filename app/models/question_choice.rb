class QuestionChoice
  include ActiveModel::Model
  attr_accessor :content, :user_id, :text, :answer_id, :question_id

  with_options presence: true do
    validates :content
  end

  validate :text_validation

  def text_validation
    text.each_with_index do |tex, i|
      if tex[:tex] == ""
        errors.add(:text, "#{i += 1}が選択されていません")
      end
    end
  end

  def save
    question = Question.create(content: content, user_id: user_id)

    text.zip(answer_id) do |str, int|
      Choice.create(text: str[:tex], answer_id: int[:ans], question_id: question.id)
    end
  end
end