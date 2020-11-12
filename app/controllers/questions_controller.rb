class QuestionsController < ApplicationController
  def new
    @question_choice = QuestionChoice.new
  end

  def create
    @question_choice = QuestionChoice.new(question_params)
    if @question_choice.save
      redirect_to root_path
    else
      redirect_to action: :new
    end
  end

  private

  def question_params
    params.require(:question_choice).permit(:content, answer_id: [:ans], text: [:tex] ).merge(user_id: current_user.id)
  end
end
