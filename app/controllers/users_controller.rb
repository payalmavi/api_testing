class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user, status: :ok
  end

  # def signed_in_user
  #   #@current_user = current_user
  #   render json: current_user, status: :ok
  # end
    

  def create
    @user = User.new(users_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private 
    def users_params
      params.require(:user).permit(:email, :password)
    end


end
