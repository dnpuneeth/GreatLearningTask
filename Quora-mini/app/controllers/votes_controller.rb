  class VotesController < ApplicationController
  def create
    @comment = Comment.find(params[:comment_id])
    @user = User.find(params[:user_id])
    @votes = @comment.votes.build(vote_params)
    @votes.user = @user
    @count = Vote.all
    upvote if vote_params[:vote].to_i.eql? 1
    downvote if vote_params[:vote].to_i.eql? -1
    redirect_to user_question_comment_path(question_id: @comment.question.id, id: @comment.id)
  end

  def upvote
    if @user.votes.upvoted(@comment.id).any?
      flash[:info] = 'You already Up voted'
    else
      if @user.votes.downvoted(@comment.id).any?
        set_votes
        @vote.first.update_attributes(vote: 1)
      else
        @votes.save
      end
      flash[:success] = 'Up Voted'
    end
  end

  def downvote
    if @user.votes.downvoted(@comment.id).any?
      flash[:info] = 'You already Down voted'
    else
      if @user.votes.upvoted(@comment.id).any?
        set_votes
        @vote.first.update_attributes(vote: -1)
      else
        @votes.save
      end
      flash[:success] = 'Down Voted'
    end
  end

  private

  def vote_params
    params.require(:votes).permit(:vote)
  end

  def set_votes
    @vote = Vote.where(comment_id: params[:comment_id], user_id: params[:user_id])
  end
end
