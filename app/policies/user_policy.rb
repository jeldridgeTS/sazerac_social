class UserPolicy < ApplicationPolicy
  def list_users?
    user.present? && user.admin?
  end
end
