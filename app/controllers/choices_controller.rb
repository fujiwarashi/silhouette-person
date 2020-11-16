class ChoicesController < ApplicationController

  def update
    @choice = Choice.where(question_id: @question.id)
    # @question = Question.find(params[:question_id])
    if @choice.update(choice_params)
      redirect_to controller: :users, action: :show
    else
      render :edit
    end
  end

  private

  def choice_params
    # params.require(:choice).permit(:title, :message, question_ids:[]).merge(user_id: current_user.id)
  end
end