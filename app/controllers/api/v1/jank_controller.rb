class Api::V1::JankController < Api::ApiController

  def create
    # authorize Article

    @article = Article.new(article_params)

    current_user.articles << @article

    if @article.save
      render :show, status: :created, locals: { article: @article }
    else
      render :show, status: :unprocessable_entity, locals: { error: @article.errors }
    end
  end
end
