class QuestionChoice
  include ActiveModel::Model
  attr_accessor :content, :user_id, :text, :answer_id, :question_id

  with_options presence: true do
    validates :content
    validates :text
  end

  def save
    question = Question.create(content: content, user_id: user_id)
    text.zip(answer_id) do |str, int|
      Choice.create(text: str[:tex], answer_id: int[:ans], question_id: question.id)
    end
  end
end