class VotesController < ApplicationController
  #before_action :set_votes
  attr_accessor :vote

  def create
    @comment = Comment.find(params[:comment_id])
    @user = User.find(params[:user_id])
    @votes = @comment.votes.build(vote_params)
    @votes.user = @user
    if @votes.save
      flash[:success] = 'Up Voted' if vote_params[:vote].to_i.eql? 1
      flash[:danger] = 'Down Voted' if vote_params[:vote].to_i.eql? -1
      redirect_to user_question_path(id: @comment.question_id)
    end
  end

  private

  def vote_params
    params.require(:votes).permit(:vote)
  end

  def set_votes
    @votes = Vote.find(params[:id])
  end
end
