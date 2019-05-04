class PagesController < ApplicationController

  def landing
    @articles = Article.published
    @users = User.all
  end
end
