class LikesController < ApplicationController
  before_action :authenticate_user!

  def show
    article = Article.find(params[:article_id])
    like_status = current_user.has_liked?(article)

    render json: like_status
  end

  def create
    article = Article.find(params[:article_id])
    current_user.likes.create!(article_id: article.id)
    
    status = 'ok'
    render json: status
  end

  def destroy
    article = Article.find(params[:article_id])
    like = current_user.likes.find_by!(article_id: article.id)
    like.destroy!
    
    status = 'ok'
    render json: status
  end
end