# -*- coding: utf-8 -*-
class Admin::PostsController < Admin::BaseController
  def index
    @posts = Post.search(params[:search], params[:page])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "成功创建帖子"
      redirect_to admin_post_path(@post)
    else
      flash[:error] = "创建帖子失败"
      redirect_to new_admin_post_path
    end
  end

  def show
    @post = Post.find(params[:id])
    @reply = Reply.new(post_id: @post.id)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = "修改成功！"
      redirect_to admin_posts_path
    else
      flash[:alert] = "修改失败!"
      render admin_post_path(@post)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to admin_posts_path
    else
      flash[:error] = "删除帖子失败"
      redirect_to @post
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def correct_user
    @user = Post.find(params[:id]).user
    redirect_to root_path, alert: "错误用户。你绝对是个坏蛋！" unless current_user?(@user)
  end
end
