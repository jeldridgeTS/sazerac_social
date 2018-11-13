class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :toggle_publish_status]

  after_action :verify_authorized, except: [:index, :show]

  # GET /articles
  # GET /articles.json
  def index
    if params[:tag]
      @articles = Article.tagged_with(params[:tag])
    else
      @articles = Article.all
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    authorize Article

    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    authorize Article

    @article = Article.new(article_params)

    current_user.articles << @article

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_show_path(@article), notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    authorize @article

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

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    authorize @article

    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def toggle_publish_status
    authorize @article
    
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
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :body, :thumb_image, :main_image, :all_tags)
    end
end
