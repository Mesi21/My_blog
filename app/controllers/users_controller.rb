class UsersController < ApplicationController
  def index
    @users = User.all
    json_response(@users)
  end

  def show
    @user = User.find(params[:id])
    json_response(set_user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
