class ResultsController < ApplicationController

  # def new
    # @exam = Exam.find(params[:id])
    # @exam_questions = ExamQuestion.where(exam_id: @exam.id)
    # @result_choice = ResultChoice.new
  # end

  def create
    @result = Result.new(result_params)
    if @result.save
      redirect_to root_path
    else
      render :new
    end
  end

  def result_params
    params.require(:result).permit(choice_ids:[]).merge(user_id: current_user.id, exam_id: params[:exam_id])
  end
  
end
