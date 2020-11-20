class ChoicesController < ApplicationController

  def edit
    @question = Question.where(user_id: params[:id])
    @choice = Choice.where(question_id: params[:question_id])
  end

  def update
    @choice = Choice.where(question_id: params[:question_id])
    if @choice.update(choice_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def choice_params
    params.require(:choice).permit(answer_id: [:ans], text: [:tex]).merge(user_id: current_user.id)
  end
end