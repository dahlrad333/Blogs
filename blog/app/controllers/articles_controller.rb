class ArticlesController < ApplicationController

   http_basic_authenticate_with name: "Rory", password: "secret", except: [:index, :show]

  def index
    @articles = Article.all
  end

  def show
  @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end


  def edit
    #how does this put the params back into their fields on the edit page?
  @article = Article.find(params[:id])
  end

  #this is when a 'new' article gets submitted
  def create
    @article = Article.new(article_params)

    #if the article gets saved, go to the article/id, otherwise reload the "new" page
    if @article.save
    redirect_to @article
    else
      render 'new'
    end
  end


  def update
  @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
  @article = Article.find(params[:id])
  @article.destroy

  redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end
end
