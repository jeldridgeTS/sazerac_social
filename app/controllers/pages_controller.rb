class PagesController < ApplicationController

  def landing
    @articles = Article.all
    @users = User.all
  end
end
