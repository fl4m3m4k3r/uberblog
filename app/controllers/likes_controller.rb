class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(like_params)

    if !@like.save
      flash[:notice] = @like.errors.full_messages.to_sentence
    end

    if params[:like][:url_from][-1].match?(/\d/)
      redirect_to post_path(@like.post) 
    else 
      redirect_to posts_path
    end
  end

  def destroy
    @like = Like.find(params[:id])
    post_id = @like.post.id
    @like.destroy

    if params[:like][:url_from][-1].match?(/\d/)
      redirect_to post_path(post_id) 
    else 
      redirect_to posts_path
    end
  end

  private

  def like_params
    params.require(:like).permit(:post_id)
  end
end
