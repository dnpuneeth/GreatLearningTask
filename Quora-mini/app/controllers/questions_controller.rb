class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  def index
    @questions = Question.all.recent
    @question = Question.new
    @user = User.find(params[:user_id])
    @question.user = @user
    @user_questions = @questions.all.usr(@user.id).recent
    @qn_comments = Comment.cmt(@questions.pluck(:id))
    @user_qn_comments = Comment.cmt(@user_questions.pluck(:id))
  end

  def show
    @comment = @question.comments.new
  end

  def new
    @question = Question.new
  end

  def edit; end

  def create
    @question = Question.new(question_params)

    user = User.find(params[:user_id])
    @question.user = user
    if @question.save
      flash[:success] = 'Question Posted Successfully.'
      redirect_to user_questions_path(user_id: @question.user_id)
    else
      render 'new'
    end
  end

  def update
    if @question.update_attributes(question_params)
      flash[:info] = 'Question Updated Successfully'
      redirect_to user_question_path(user_id: params[:user_id], id: @question.id)
    else
      render 'edit'
    end
  end

  def destroy
    @question.destroy
    flash[:danger] = 'Question Deleted Successfuly'
    redirect_to user_questions_path(user_id: @question.user_id)
  end

  def myquestions
    @questions = Question.all.usr(params[:user_id]).recent
    @question = Question.new
    @user = User.find(params[:user_id])
    @question.user = @user
    @qn_comments = Comment.cmt(@questions.pluck(:id))
  end

  private

  def question_params
    params.require(:question).permit(:question, :description)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
