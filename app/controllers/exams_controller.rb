class ExamsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_exam, only: [:edit, :update, :destroy]

  def index
    @exams = Exam.where(status: 1).order(id: "DESC")
  end

  def new
    @exam = Exam.new
    @question = Question.where(params[:id])
  end

  def show
    if @exam = Exam.find_by(id_digest: params[:id])
       @exam_questions = ExamQuestion.where(exam_id: @exam.id)
       @result = Result.new
       @result_choice = ResultChoice.new
    else
      redirect_to root_path
    end
  end

  def edit
    redirect_to root_path if @exam.user_id != current_user.id
  end

  def update
    if @exam.update(exam_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def create
    @exam = Exam.new(exam_params)
    if @exam.status == 2 && @exam.save
    elsif @exam.save
      redirect_to root_path    
    else
      render :new
    end
  end

  def destroy
    if @exam.user_id != current_user.id
      redirect_to root_path
    elsif @exam.destroy
      redirect_to user_path(current_user)
    end
  end

  private

  def exam_params
    params.require(:exam).permit(:title, :message, :status, question_ids:[]).merge(user_id: current_user.id)
  end

  def set_exam
    if Exam.exists?(id: params[:id])
      @exam = Exam.find(params[:id])
    else
      redirect_to root_path
    end
  end
end