# -*- coding: utf-8 -*-
class Admin::UsersController < Admin::BaseController
  def index
    @users = User.search(params[:search], params[:page])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.recent
    @invitations = @user.invitations
    @applies = @user.applies
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "添加成功！"
      redirect_to admin_users_path
    else
      flash[:alert] = "添加失败！"
      render new_admin_user_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "修改成功！"
      redirect_to admin_users_path
    else
      flash[:alert] = "修改失败!"
      redirect_to admin_user_path(@user)
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = "删除成功！"
    else
      flash[:alert] = "删除失败!"
    end
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :id_num, :email, :phone_num, :gender, :from_class, :department, :admin)
  end
end
