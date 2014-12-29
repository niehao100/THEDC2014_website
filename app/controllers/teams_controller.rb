# -*- coding: utf-8 -*-
class TeamsController < ApplicationController
  include SessionsHelper
  
  before_action :signed_in_user, only: [:new, :create, :edit, :update, :delete, :destroy]
  before_action :correct_leader_user, only: [:edit, :update, :delete, :destroy]

  def index
    @teams = Team.search(params[:search], params[:page])
  end

   def new
     if current_user.can_create_team?
       @team = Team.new
     else
       flash[:notice] = "无法创建团队。是不是已经加入了别的队伍？"
       redirect_to root_url
     end
   end

   def create
     @team = Team.new(team_params)
     if current_user.can_create_team?
       if @team.save
         @team.add_as_leader(current_user) # 这里用户cookie被劫持就不好了
         @team.save
         current_user.clear_applies_and_invitations
         flash[:success] = "创建成功！"
         redirect_to @team
       else
         flash[:alert] = "创建失败！"
         render 'new'
       end
     else
       flash[:notice] = "无法创建团队。是不是已经加入了别的队伍？"
       redirect_to root_url
     end
   end

  def show
    @team = Team.find(params[:id])
    @posts = @team.posts.recent
    @invitations = @team.invitations
    @applies = @team.applies
    @informs = Inform.recent
    @trials = @team.trials.order(:start_time)
  end

   def edit
   end

   def update
     if @team.update_attributes(team_params)
       flash[:success] = "修改成功！"
       redirect_to @team
     else
       flash[:alert] = "修改失败!"
       render 'edit'
     end
   end

   def delete
   end

   def destroy
     if @team.destroy
       flash[:success] = "成功解散队伍！"
     else
       flash[:alert] = "删除失败。你要干什么！？"
     end
     redirect_to root_url
   end
  private

  def team_params
    params.require(:team).permit(:name, :group)
  end

  def correct_leader_user
    @team = Team.find(params[:id])
    redirect_to root_path, alert: "错误用户。你绝对是个坏蛋！" unless @team.leader?(current_user)
  end
end
