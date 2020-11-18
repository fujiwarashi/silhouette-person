class ResultsController < ApplicationController

  def show
    # @exam = Exam.find(params[:id])
    # @exam_questions = ExamQuestion.where(exam_id: @exam.id)
    # @result_choice = ResultChoice.find(params[:id])
    
    @result = Result.find(params[:id])
    user = User.where(id: @result[:user_id])
    @user = user
    @exam = Exam.find(@result[:exam_id])
    @exam_questions = ExamQuestion.where(exam_id: @exam.id)
    @result_choice = ResultChoice.where(result_id: params[:id])
    # binding.pry
    # @question = Question.where[id: @exam_questions[:question_id]]



    # results = Result.where(exam_id: user.exams)
    # @results_not = results.where.not(user_id: current_user.id).order(id: "DESC")
    # choice_true = Choice.where(answer_id: 2)
    # result_choice = ResultChoice.where(result_id: @result.ids)
    # result_choices = ResultChoice.where(result_id: @results_not.ids)
    # @result_choice_true = result_choice.where(choice_id: choice_true.ids)
    # @result_choices_true = result_choices.where(choice_id: choice_true.ids)
  end

  def create
    @exam = Exam.find(params[:exam_id])
    @result = Result.new(result_params)
    if @result.save
      redirect_to root_path
      # redirect_to controller: :result, action: :show, params[:id]
    else
      render controller: :exam, action: :show
    end
  end

  def destroy
  end

  def result_params
    params.require(:result).permit(choice_ids:[]).merge(user_id: current_user.id, exam_id: params[:exam_id])
  end
  
end