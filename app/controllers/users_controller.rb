class UsersController < ApplicationController
  before_action :authorize_request, except: [:index, :create]
  before_action :set_user, only: [:show, :update, :destroy]
  def index
    @users = User.all
    render json: @users
  end
 
  def show
    render json: @user, status: :ok
  end

  def signed_in_user
    #@current_user = current_user
    render json: current_user, status: :ok
  end
    

  def create
    @user = User.new(users_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
     if @user.id ==(params[:id]).to_i
      @user.update
      render json: { success: "User successfully deleted"}, status: :ok
    else
      render json: {error: "You are not authorized to update the profile of another users."}, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.id ==(params[:id])
      @user.destroy
      render json: { success: "User successfully deleted"}, status: :ok
    else
      render json: {error: "You are not authorized to delete the profile of another users."}, status: :unprocessable_entity
    end
  end


  private 
    def users_params
      params.require(:user).permit(:email, :password, :user_id)
    end

    def set_user
      @user = current_user
      #debugger
    end


end
