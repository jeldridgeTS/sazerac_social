class Api::V1::ArticlesController < Api::ApiController
  skip_before_action :authenticate, only: [:index, :show]

  before_action :set_article, only: [:show, :edit, :update, :destroy, :toggle_publish_status]
  after_action :verify_authorized, except: [:index, :show]

  # GET /api/v1/articles
  def index
    @articles = params[:tag] ? Article.tagged_with(params[:tag]).published : Article.published
    render json: { articles: @articles }
  end

  def show
    render json: { article: @article }
  end

  # POST /api/v1/articles
  def create
    authorize Article

    @article = Article.new(article_params_with_upload)

    current_user.articles << @article

    if @article.save
      render json: { created: true, article: @article }
    else
      render json: { status: :unprocessable_entity, locals: { error: @article.errors } }
    end
  end

  # PATCH/PUT api/v1/articles/1
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_show_path(@article), notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE api/v1/articles/1
  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def toggle_publish_status
    if @article.published?
      @article.draft!
    elsif @article.draft?
      @article.published!
    end

    redirect_to article_show_path(@article)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.friendly.find(params[:id])
    authorize @article
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def article_params
    params.require(:article).permit(
      :title,
      :body,
      :main_image,
      :main_image_title,
      :main_image_alt_text,
      :thumb_image,
      :all_tags
    )
  end

  def article_params_with_upload
    params.permit(
      :title,
      :body,
      :main_image,
      :main_image_title,
      :main_image_alt_text,
      :thumb_image,
      :all_tags,
      :jumbotron_image
    )
  end
end
