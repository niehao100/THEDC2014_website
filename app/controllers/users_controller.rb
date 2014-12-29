# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  include SessionsHelper
  before_action :signed_in_user, only: [:edit, :update, :delete, :destroy]
  before_action :correct_user, only: [:edit, :update, :delete, :destroy]

  def index
    @users = User.search(params[:search], params[:page])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.recent
    @informs = Inform.recent
    @invitations = @user.invitations
    @applies = @user.applies
  end

  def new
    if signed_in?
      redirect_to root_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user,false)
      flash[:success] = "欢迎参加电设大赛！"
      redirect_to @user
    else
      flash[:alert] = "注册失败！"
      render 'new'
    end
  end

  def edit
  end
  
  def update
    if !@user.authenticate(params[:user][:oldpassword])
      flash[:error] = "旧密码错误！你绝对是个坏蛋！"
      render 'edit'
    elsif @user.update_attributes(user_params)
      flash[:success] = "修改成功！"
      sign_in(@user,false)
      redirect_to @user
    else
      flash[:error] = "修改失败!"
      render 'edit'
    end
  end

  def delete
  end

  def destroy
    if !@user.authenticate(params[:user][:current_password])
      flash[:error] = "旧密码错误！你绝对是个坏蛋！"
    else
      sign_out
      if @user.destroy
        flash[:success] = "成功删除帐号！杀羊那拉‘-’"
      else
        flash[:error] = "删除失败。不要走:("
      end
    end
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :id_num, :email, :phone_num, :password, :password_confirmation, :gender, :from_class, :department)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path, alert: "错误用户。你绝对是个坏蛋！" unless current_user?(@user)
  end
end
