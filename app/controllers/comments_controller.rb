# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @commentable
    else
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
