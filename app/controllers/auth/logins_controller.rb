class Auth::LoginsController < ApplicationController
  # skip_before_action :authentication

  def new; 
    if current_user
      redirect_to users_path
    end
  end

  def login
    # pp params
    # pp params[:user][:password]
    # pp params["user"]["password"]
    user = User.find_by(email: permitted_params[:email])
    if user && user.password == permitted_params[:password]
      session[:current_user_id] = user.id
      flash[:success] = ['You are logged in']
      token = encode_user_data({ user_data: user.id, email: user.email })
      flash[:success] = ["You are logged in with token #{token}" ]
      redirect_to users_path
    else
      flash[:danger] = ["invalid credentials" ]
      redirect_to login_path
    end
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to login_path
  end

  # private

  def permitted_params
    params.require(:user).permit(:email, :password)
  end
end
