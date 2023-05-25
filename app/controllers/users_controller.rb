class UsersController < ApplicationController
  # skip_before_action :logged_in?, only: [:new, :create]
  skip_before_action :verify_authenticity_token
  before_action :authentication

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    user = User.new permitted_params
    user.save!
    # if user is saved
    if user.save
      # we encrypt user info using the pre-define methods in application controller
      token = encode_user_data({ user_data: user.id, email: user.email })
      
      # return to user
      flash[:success] = ["User has been created with token #{token}" ]
      redirect_to login_path
    else
      # render error message
      flash[:danger] = ["Error: User is not saved" ]
      redirect_to login_path
    end
    # user = User.new permitted_params
    # user.save!
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update!(permitted_params)
  end
    
  private

  def permitted_params
    params.require(:user).permit(:email, :password)
  end
end
