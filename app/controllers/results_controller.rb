class ResultsController < ApplicationController

  def show
    @exam = Exam.find(params[:id])
    @exam_questions = ExamQuestion.where(exam_id: @exam.id)
    @result_choice = ResultChoice.find(params[:id])
  end

  def create
    @result = Result.new(result_params)
    if @result.save
      redirect_to root_path
    else
      render template: "exams/show"
    end
  end

  def destroy
  end

  def result_params
    params.require(:result).permit(choice_ids:[]).merge(user_id: current_user.id, exam_id: params[:exam_id])
  end
  
end
