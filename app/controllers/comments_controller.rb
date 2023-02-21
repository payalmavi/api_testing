class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @comments = Comment.all
    render json: @comments
  end

end
