class ExamsController < ApplicationController
  def index
    @exams = Exam.all.order(id: "DESC")
  end

  def new
    @exam = Exam.new
    @question = Question.where(params[:id])
  end

  def show
    @exam = Exam.find(params[:id])
    @exam_questions = ExamQuestion.where(exam_id: @exam.id)
    @result = Result.new
    @result_choice = ResultChoice.new
  end

  def create
    @exam = Exam.new(exam_params)
    if @exam.save
      redirect_to root_path
    else
      render :new
    end
  end

  def exam_params
    params.require(:exam).permit(:title, :message, question_ids:[]).merge(user_id: current_user.id)
  end
end
