class CommentsController < ApplicationController
  before_action :load_comment, only: %i(edit update destroy)
  before_action :logged_in_member, only: %i(create destroy)

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_member.comments.build comment_params
    if @comment.save
      flash.now[:success] = t ".success"
    else
      flash.now[:danger] = t ".failed"
    end
  end

  def edit;end

  def update
    if @comment.update comment_params
      flash.now[:success] = t ".success"
    else
      flash.now[:danger] = t ".failed"
    end
  end

  def destroy
    if @comment.destroy
      flash.now[:success] = t ".success"
    else
      flash.now[:danger] = t ".failed"
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content, :story_id, :member_id
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]
    return if @comment
    redirect_to root_url
    flash[:danger] = t ".notfound"
  end
end
