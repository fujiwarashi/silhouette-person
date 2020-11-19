class UsersController < ApplicationController

  def show
    user = User.find(params[:id])
    @user = user
    @exam = user.exams.order(id: "DESC")
    @question = user.questions.order(id: "DESC")
    @result = user.results.order(id: "DESC")
    results = Result.where(exam_id: user.exams)
    @results_not = results.where.not(user_id: current_user.id).order(id: "DESC")
  end
end