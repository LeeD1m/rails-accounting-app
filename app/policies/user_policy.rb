class UserPolicy < ApplicationPolicy
  def reset_passwords?
    @current_user.role&.admin?
  end
end
