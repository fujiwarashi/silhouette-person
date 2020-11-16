class QuestionsController < ApplicationController
  def new
    @question_choice = QuestionChoice.new
  end

  def create
    @question_choice = QuestionChoice.new(question_params)
    if @question_choice.save
      redirect_to :new
    else
      render :new
    end
  end

  def show
  end

  def edit
    @question = Question.find(params[:exam_id])
    @choice = Choice.where(question_id: @question.id)
    binding.pry
    redirect_to root_path if @question.user_id != current_user.id
  end

  def update
    @question = Question.find(params[:question_id])
    if @question.update(question_params)
      redirect_to controller: :users, action: :show
    else
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:exam_id])
    if @question.user_id != current_user.id
      redirect_to root_path
    elsif @question.destroy
      redirect_to controller: :users, action: :show
    end
  end

  private

  def question_params
    params.require(:question_choice).permit(:content, answer_id: [:ans], text: [:tex] ).merge(user_id: current_user.id)
  end
end
