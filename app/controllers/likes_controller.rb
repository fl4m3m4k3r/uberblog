class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(like_params)

    if !@like.save
      flash[:notice] = @like.errors.full_messages.to_sentence
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    Like.find(params[:id]).destroy

    redirect_back(fallback_location: root_path)
  end

  private

  def like_params
    params.require(:like).permit(:post_id)
  end
end
