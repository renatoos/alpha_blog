class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    # @articles = Article.all
    @articles = Article.paginate(page: params[:page], per_page: per_page)
    @articles_pages = Article.count / per_page
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    # render plain: @article.inspect

    @article.user = User.first

    if @article.save
      flash[:notice] = 'Article was created succesfully'
      redirect_to article_path(@article)
      # redirect_to @article     # short version of redirect
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
    @article.user = User.first
    if @article.update(article_params)
      flash[:notice] = 'Article was updated succesfully'
      redirect_to article_path(@article)
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

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def per_page
    5
  end
end
