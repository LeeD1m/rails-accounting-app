class ApplicationController < ActionController::Base
  # before_action :authentication
  SECRET = "yoursecretword"

  def logged_in?
    unless current_user
      flash[:danger] = ['Unathorized user']
      redirect_to root_path
    end
  end

  def current_user
    User.find_by(id: session[:current_user_id])
  end

  helper_method :current_user

  def encode_user_data(payload)
    token = JWT.encode payload, SECRET, "HS256"
    return token
  end

  def decode_user_data(token)
    begin
      data = JWT.decode token, SECRET, true, { algorithm: "HS256" }
      return data
    rescue => e
      puts e
    end
  end


  # def authentication
  #   decode_data = decode_user_data(request.headers["token"])
  #   user_data = decode_data[0]["user_id"] unless !decode_data
  #   user_id = decode_data[0]["user_id"] if decode_data
  #   user_email = decode_data[0]["email"] if decode_data

  #   user = User.find(user_data&.id)
  #   if user
  #     return true
  #   else
  #     render json: { message: "invalid credentials" }
  #   end
  # end

end
