class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    article = Article.find(params[:article_id])
    comments = article.comments.includes(:user).map do |comment|
      comment.as_json(include: { user: { methods: :avatar_image_url } })
    end

    render json: comments
  end

  def create
    article = Article.find(params[:article_id])
    comment = article.comments.build(comment_params)
    comment.user = current_user
    comment.save!

    render json: comment.as_json(include: { user: { methods: :avatar_image_url } })
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end