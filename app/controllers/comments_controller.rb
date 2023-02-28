class CommentsController < ApplicationController
	before_action :authorize_request
	before_action :comments_for_specific_post, only:[:index]

	def index
		render json: @comment
	end

	def show
		comment = Comment.find(params[:id])
		render json: comment
	end

	def create
		@comment = current_user.comments.create!(comment_params)

		if @comment.save
			render json: @comment, status: :ok
		else
			render json: @comment.errors.full_messages, status: :unprocessable_entity
		end
	end

	def update
		@comment = Comment.find(params[:id])
		if @comment.user_id == current_user.id
			@comment.update(comment_params)
			render  json: @comment, status: :ok
		else
			render json: {error:"Not authorized to update the comment."}, status: :unprocessable_entity
		end
	end

	def destroy
		@comment = Comment.find(params[:id])
		if @comment.user_id == current_user.id
			@comment.destroy
			render  json: {success: "You have succefully deleted comment"}
		else
			render json: {error: "Not authorized to delete the comment."}, status: :unprocessable_entity
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:comment, :post_id)
	end

	def comments_for_specific_post
		@posts = current_user.posts
		@posts.each do|post|
			@id = post.id
		  @comment = Post.find(@id).comments
		  # render json: @comment
		end
	end

end
