class QuestionsController < ApplicationController
  def new
    @question_choice = QuestionChoice.new
  end

  def create
    @question_choice = QuestionChoice.new(question_choice_params)
    if @question_choice.valid?
      @question_choice.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    @question = Question.find(params[:id])
    redirect_to root_path if @question.user_id != current_user.id
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])
    if @question.user_id != current_user.id
      redirect_to root_path
    elsif @question.destroy
      redirect_to root_path
    end
  end

  private

  def question_params
    params.require(:question).permit(:content).merge(user_id: current_user.id)
  end

  def question_choice_params
    params.require(:question_choice).permit(:content, answer_id: [:ans], text: [:tex] ).merge(user_id: current_user.id)
  end
end
