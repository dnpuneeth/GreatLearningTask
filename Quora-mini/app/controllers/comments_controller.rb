class CommentsController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @user = User.find(params[:user_id])
    @comment = @question.comments.build(comment_params)
    @comment.user = @user
    flash[:success] = 'Comment added' if @comment.save
    redirect_to user_question_path(user_id: @question.user_id, id: @question.id)
  end

  def show
    @comment = Comment.find(params[:id])
    @votes = @comment.votes.new
    @count = Vote.all
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
