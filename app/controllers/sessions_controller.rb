# -*- coding: utf-8 -*-
class SessionsController < ApplicationController
  include SessionsHelper

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in(user, params[:session][:remember_me])
      flash[:success] = '成功登入'
      redirect_back_or user
    else
      flash[:alert] = '登入信息无效'
      redirect_to root_path
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
