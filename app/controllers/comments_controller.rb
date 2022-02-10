class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :edit, :update]
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @comment = current_user.comments.new(comment_params)
    if !@comment.save
      flash[:notice] = @comment.errors.full_messages.to_sentence
    end

    redirect_to post_path(params[:post_id])
  end

  def destroy
    post_id = @comment.post.id
    @comment.destroy
    redirect_to post_path(post_id), notice: 'Comment was successfully destroyed.'
  end

  def edit
    render partial: 'comments/form', locals: {comment: @comment, post: @comment.post}
  end

  def update
    if @comment.update(comment_params)
      redirect_to post_path(params[:post_id]), notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  private
    def comment_params
      params
      .require(:comment)
      .permit(:body)
      .merge(post_id: params[:post_id])
    end

    def set_comment
      @comment = current_user.comments.find(params[:id])
    end
end
