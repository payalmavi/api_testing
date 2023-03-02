class PostsController < ApplicationController
  #before_action :authorize_request, only:[:index, :create]
  before_action :authorize_request
  before_action :find_post, only: [:show, :update, :destroy]

  def index
    @posts = current_user.posts.all.long_title
    render json: @posts, each_serializer: PostSerializer
  end

  def show
    #@post = current_user.posts.find(params[:id])
    render json: @post
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      render json: @post, status: :created
    else
      render json: {errors: @post.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      render json: {success: "Post has been succefully updates"}, status: :ok
    else
      render json: {errors: @post.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy
      render json: {success: "You have succefully deleted the post."}
    else
      render json: {errors: @post.errors.full_messages}, status: :unprocessable_entity
    end
  end

  # def destroy
  #   post = Post.find(params[:id])
  #   if post.user_id != params[:user_id].to_i
  #     render json: { error: "User ID does not match post owner" }, status: :unprocessable_entity
  #   else
  #     post.destroy
  #     render json: { success: "Post deleted successfully" }, status: :ok
  #   end
  # end


      
  private
    def post_params
      params.require(:post).permit(:title, :description)
    end

    def find_post
      @post = current_user.posts.find(params[:id])
    end
end
