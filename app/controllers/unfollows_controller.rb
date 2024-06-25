class UnfollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:account_id])
    current_user.unfollow!(user)
    redirect_to account_path(params[:account_id])
  end
end