# frozen_string_literal: true

class ApplicationPolicy
  class ActionForbiddenError < StandardError; end

  def initialize(current_user, resource)
    @current_user = current_user
    @resource = resource
  end

  def result(action)
      raise ActionForbiddenError unless send("#{action}?") 
  end

  class << self
    def authorize!(current_user, resource, action)
      new(current_user, resource).result(action)
    end
  end

end
