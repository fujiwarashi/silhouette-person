class UsersController < ApplicationController
  before_action :authenticate_user!

  def show 
    if User.exists?(id: params[:id]) && params[:id].to_i == current_user.id
      user = User.find(params[:id])
      @user = user
      @exam = user.exams.order(id: "DESC")
      @question = user.questions.order(id: "DESC")
      result = user.results
      @result_not = result.where.not(exam_id: @exam.ids).order(id: "DESC")
      @results = Result.where(exam_id: user.exams).order(id: "DESC")
    else
      redirect_to root_path
    end
  end
end