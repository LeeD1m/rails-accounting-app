class UsersController < ApplicationController
  before_action :logged_in?
  skip_before_action :logged_in?, only: [:new, :create]
  skip_before_action :verify_authenticity_token
  # before_action :authentication

  def index
    if current_user.actor.admin?
      @users = User.all
    else
      @users = User.employees
    end
  end

  def new
    @user = User.new
  end

  def create
    user = User.new permitted_params
    user.save!

    actor = Actor::TYPES[params[:user][:actor_type]].create(user_id: user.id)
    user.actor = actor
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
    UserPolicy.authorize!(current_user, @user, :edit_users)

  end

  def update
    @user = User.find(params[:id])
    UserPolicy.authorize!(current_user, @user, :edit_users)
    @user.update!(permitted_params)

    actor_type = params[:user][:actor_type]
    if Actor::TYPES.include?(actor_type) && actor_type != @user.actor_type
      @user.actor.destroy if @user.actor
  
      new_actor = Actor::TYPES[actor_type].create!(user_id: @user.id)
      @user.actor = new_actor
      @user.save!
    end
    
    
    

    flash[:success] = ["User has been updated" ]
    redirect_to login_path
  end

  def assign_actor(actor_type)
    # 'Admin', 'Employee'
    if Actor::TYPES.include?(actor_type)
    else
      raise "Unknown actor type: #{actor_type}"
    end
end
    
  private

  def permitted_params
    params.require(:user).permit(:email, :password)
  end
end
