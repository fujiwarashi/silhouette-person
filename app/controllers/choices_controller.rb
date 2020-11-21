class ChoicesController < ApplicationController

  def edit
    @question = Question.where(user_id: params[:id])
    @choice = Choice.where(question_id: params[:question_id])
  end

  def update
    @choice = Choice.find(params[:id])
    if @choice.update(choice_params)
      redirect_to question_path(params[:question_id])
    else
      render :edit
    end
  end

  private

  def choice_params
    params.require(:choice).permit(:answer_id, :text)
  end
end