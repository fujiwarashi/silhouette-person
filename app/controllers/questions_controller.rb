class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def new
    @question_choice = QuestionChoice.new
  end

  def create
    @question_choice = QuestionChoice.new(question_choice_params)
    if @question_choice.valid?
      @question_choice.save
      redirect_to new_question_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    redirect_to root_path if @question.user_id != current_user.id
  end

  def update
    if @question.update(question_params)
      redirect_to question_path(params[:id])
    else
      render :edit
    end
  end

  def destroy
    if @question.user_id != current_user.id
      redirect_to root_path
    elsif @question.destroy
      redirect_to user_path(current_user.id)
    end
  end

  private

  def question_params
    params.require(:question).permit(:content, :allocation_id, :image).merge(user_id: current_user.id)
  end

  def question_choice_params
    params.require(:question_choice).permit(:content, :allocation_id, :image, answer_id: [:ans], text: [:tex] ).merge(user_id: current_user.id)
  end

  def set_question
    if Question.exists?(id: params[:id])
      @question = Question.find(params[:id])
    else
      redirect_to root_path
    end
  end
end
