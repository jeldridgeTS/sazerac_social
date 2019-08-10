class Api::V1::ArticlesController < Api::ApiController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :toggle_publish_status]
  after_action :verify_authorized, except: [:index, :show]

  # GET /api/v1/articles
  def index
    @articles = params[:tag] ? Article.tagged_with(params[:tag]).published : Article.all#Article.published
  end

  # POST /api/v1/articles
  def create
    authorize Article

    @article = Article.new(article_params)

    current_user.articles << @article

    if @article.save
      render json: { created: true, article: @article }
    else
      render json: { status: :unprocessable_entity, locals: { error: @article.errors } }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.friendly.find(params[:id])
    authorize @article
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def article_params
    params.require(:article).permit(:title, :body, :thumb_image, :main_image, :all_tags, :main_image_title, :main_image_alt_text)
  end
end
