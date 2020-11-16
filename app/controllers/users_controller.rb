class UsersController < ApplicationController

  def show
    user = User.find(params[:id])
    @user = user
    @exam = user.exams
    @question = user.questions
    @result = user.results
    @results = Result.where(exam_id: user.exams)
  end
end
