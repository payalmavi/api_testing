class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.all
    render json: @post
  end

  # def show
  #   render json: @user, status: :ok
  # end

  # def signed_in_user
  #   #@current_user = current_user
  #   render json: current_user, status: :ok
  # end
      

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
   @post.destroy
  end

  private 
    def post_params
      params.require(:post).permit(:name, :user_id)
    end


end
