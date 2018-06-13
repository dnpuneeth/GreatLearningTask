class VotesController < ApplicationController
  before_action :set_votes
  def create
    byebug
    @comment = Comment.find(params[:comment_id])
    @user = User.find(params[:user_id])
    @votes = @comment.votes.build(vote_params)
    @votes.user = @user
  end

  private

  def vote_params
    params.require(:votes).permit(:vote)
  end

  def set_votes
    @votes = Vote.find(params[:id])
  end
end
