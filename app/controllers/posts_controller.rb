class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  def index
    return @posts = Post.all.includes(:user, :likes, :comments).order("created_at DESC") unless params[:post] && params[:post][:order]

    case params["post"]["order"]
    when 'created_at, descending' then @posts = Post.all.includes(:user, :likes, :comments).order("created_at DESC")
    when 'created_at, ascending' then @posts = Post.all.includes(:user, :likes, :comments).order("created_at ASC")
    when 'likes, descending' then @posts = Post.all.includes(:user, :likes, :comments).sort_by { |post| -post.likes.count }
    when 'likes, ascending' then @posts = Post.all.includes(:user, :likes, :comments).sort_by { |post| post.likes.count }
    when 'comments, descending' then @posts = Post.all.includes(:user, :likes, :comments).sort_by { |post| -post.comments.count }
    when 'comments, ascending' then @posts = Post.all.includes(:user, :likes, :comments).sort_by { |post| post.comments.count }
    end
  end

  # GET /posts/1
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:user_id, :title, :body)
    end
end
