class ResultsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_result, only: [:show, :destroy]

  def show
    @result = Result.find(params[:id])
    @exam = Exam.find(@result[:exam_id])
    @exam_questions = ExamQuestion.where(exam_id: @exam.id)
    redirect_to root_path if @exam.user_id != current_user.id && @result.user_id != current_user.id
  end

  def create
    @exam = Exam.find_by(id_digest: params[:exam_id])
    @exam_questions = ExamQuestion.where(exam_id: @exam.id)
    @result = Result.new(result_params)
    if @result.valid? 
      @result.save
    else
      @caution = "何も選択されていません"
      render inline: "<%= @caution %>"
    end
  end

  def destroy
    @result = Result.find(params[:id])
    exam = Exam.find(@result.exam_id)
    if exam.user_id != current_user.id
      redirect_to root_path
    elsif @result.destroy
      redirect_to user_path(current_user)
    end
  end

  def result_params
    params.require(:result).permit(choice_ids:[]).merge(user_id: current_user.id, exam_id: @exam.id)
  end
  
  def set_result
    unless Result.exists?(id: params[:id])
      redirect_to root_path
    end
  end
end