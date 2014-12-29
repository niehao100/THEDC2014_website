# -*- coding: utf-8 -*-
module SessionsHelper
  
  def sign_in(user, remember)  # 创建新的session口令，分别存在数据库（/内存？）和客户端cookie上
    remember_token = user.new_token
    if remember
      cookies.permanent[:remember_token] = remember_token
    else
      cookies[:remember_token] = remember_token
    end
    user.update_attribute(:remember_token, encrypt_token(remember_token))
    self.current_user = user
  end
  
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    remember_token = encrypt_token(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user?(user)
    current_user == user
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to root_path, notice: "请登入" 
    end
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end
  
  def store_location
    session[:return_to] = request.fullpath
  end

  def encrypt_token(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def leader_user
    unless current_user.leader?
      redirect_to root_path, alert: "错误用户。你绝对是个坏蛋！"
    end
  end

  def require_admin_user
    unless current_user.admin?
      redirect_to root_path, alert: "错误用户。你绝对是个坏蛋！"
    end
  end
end
