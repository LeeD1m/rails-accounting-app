class UsersController < ApplicationController
  before_action :logged_in?
  skip_before_action :logged_in?, only: [:new, :create]
  skip_before_action :verify_authenticity_token
  # before_action :authentication

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    user = User.new permitted_params
    user.save!
    if user.save
      token = encode_user_data({ user_data: user.id, email: user.email })
      flash[:success] = ["User has been created with token #{token}" ]
      redirect_to login_path
    else
      flash[:danger] = ["Error: User is not saved" ]
      redirect_to login_path
    end
  end

  def edit
    @user = User.find(params[:id])
    # UserPolicy.authorize!(current_user, @user, :reset_passwords)

  end

  def update
    @user = User.find(params[:id])
    # UserPolicy.authorize!(current_user, @user, :reset_passwords)
    @user.update!(permitted_params)
  end
    
  private

  def permitted_params
    params.require(:user).permit(:email, :password)
  end
end
