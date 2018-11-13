class ArticlePolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    @user.writer? || @user.admin?
  end
end
