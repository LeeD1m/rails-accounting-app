class Auth::LoginsController < ApplicationController
  # skip_before_action :authentication

  def new; 
    # if current_user
    #   redirect_to users_path
    # end
  end

  def login
    user = User.find_by(email: permitted_params[:email])
    # render json: { user: user }
    # you can use bcrypt to password authentication
    if user && user.password == permitted_params[:password]

      # we encrypt user info using the pre-define methods in application controller
      token = encode_user_data({ user_data: user.id, email: user.email })

      # return to user
      # render json: { token: token }
      flash[:success] = ["You are logged in with token #{token}" ]
      redirect_to users_path
    else
      # render json: { message: "invalid credentials" }
      flash[:danger] = ["invalid credentials" ]
      redirect_to login_path
    end
  end

  def destroy
    token = nil
    redirect_to login_path
  end

  # private

  def permitted_params
    params.require(:user).permit(:email, :password)
  end
end
