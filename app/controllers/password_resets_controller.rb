# -*- coding: utf-8 -*-
class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:password_reset][:email])
    if user
      user.send_password_reset 
      redirect_to root_url, notice: "重置邮件装填...发射..."
    else
      redirect_to new_password_reset_path, alert: "failed"
    end
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 1.hours.ago
      redirect_to new_password_reset_path, :alert => "Password &crarr; 
      reset has expired."
    elsif @user.update_attributes(user_params)
      redirect_to root_url, :notice => "Password has been reset."
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
