class ChoicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_choice, only: :edit

  def edit
    @choice = Choice.find_by(id: params[:id])
    redirect_to root_path if @choice.question.user_id != current_user.id
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

  def set_choice
    unless Choice.exists?(id: params[:id])
      redirect_to root_path
    end
  end
end