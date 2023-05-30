class UserPolicy < ApplicationPolicy

  def edit_users?
    @current_user.role == 'admin'
  end

end
