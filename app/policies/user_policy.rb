class UserPolicy < ApplicationPolicy
  # TODO: Possibly refactor and move admin methods to an admin policy
  # ex: https://github.com/varvet/pundit#headless-policies
  def list_users?
    user.present? && user.admin?
  end
end
