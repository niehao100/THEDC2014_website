# -*- coding: utf-8 -*-
class Admin::RepliesController < Admin::BaseController
  def create
    @reply = current_user.replies.build(reply_params)
    if @reply.save
      flash[:success] = "回复成功"
    else
      flash[:error] = "回复失败"
    end
    redirect_to admin_post_path(Post.find(params[:reply][:post_id]))
  end

  def destroy
    @reply = Reply.find(params[:id])
    if @reply.destroy
      flash[:success] = "删除成功"
    else
      flash[:error] = "删除失败"
    end
    redirect_to admin_post_path(Post.find(@reply.post))
  end

  private
  
  def reply_params
    params.require(:reply).permit(:content, :post_id)
  end
end
