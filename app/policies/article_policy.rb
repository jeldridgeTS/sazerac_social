class ArticlePolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    @user.writer? || @user.admin?
  end

  def update?
    user.present? && user.eql?(record.user)
  end

  def toggle_publish_status?
    update? || user.admin?
  end
end
