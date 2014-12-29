# -*- coding: utf-8 -*-
class RepliesController < ApplicationController
  include SessionsHelper
  before_action :signed_in_user, only: [:create]
  def create
    @reply = current_user.replies.build(reply_params)
    if @reply.save
      flash[:success] = "回复成功"
    else
      flash[:error] = "回复失败"
    end
    redirect_to post_path(Post.find(params[:reply][:post_id]))
  end

  private
  
  def reply_params
    params.require(:reply).permit(:content, :post_id)
  end
end
