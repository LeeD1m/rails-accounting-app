class UserPolicy < ApplicationPolicy

  def edit_users?
    @current_user.actor.admin?
  end

end
