class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params.require(:user).permit(:name, :image, :profile))
      flash[:notice] = "#{@user.name}さんの情報を更新しました"
      redirect_to edit_user_path
    else
      render "edit"
    end
  end
end
