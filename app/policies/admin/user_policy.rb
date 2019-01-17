class Admin::UserPolicy < Admin::ApplicationPolicy
  def index?
    dashboard?
  end

  def show?
    dashboard?
  end

  def dashboard?
    user.present? && user.admin?
  end

  def find_by_display_name?
    dashboard?
  end

  def search_users?
    dashboard?
  end

  def add_role?
    dashboard?
  end

  # TODO: Possibly refactor and move admin methods to an admin policy
  # ex: https://github.com/varvet/pundit#headless-policies
  def list_users?
    user.present? && user.admin?
  end
end
