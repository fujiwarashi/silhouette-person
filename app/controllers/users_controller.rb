class UsersController < ApplicationController

  def show
    user = User.find(params[:id])
    @user = user
    @exam = user.exams
    @question = user.questions
    @result = user.results.order(id: "DESC")
    results = Result.where(exam_id: user.exams)
    @results_not = results.where.not(user_id: current_user.id).order(id: "DESC")
    choice_true = Choice.where(answer_id: 2)
    result_choice = ResultChoice.where(result_id: @result.ids)
    result_choices = ResultChoice.where(result_id: @results_not.ids)
    @result_choice_true = result_choice.where(choice_id: choice_true.ids)
    @result_choices_true = result_choices.where(choice_id: choice_true.ids)
  end
end