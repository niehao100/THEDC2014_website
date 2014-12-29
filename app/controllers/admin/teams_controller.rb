# -*- coding: utf-8 -*-
class Admin::TeamsController < Admin::BaseController
  include SessionsHelper
  
  def index
    @teams = Team.search(params[:search], params[:page])
  end

  def print
    @teams = Team.all.order(:created_at)
  end

  def print_survived
    @teams = Team.where('survived = TRUE')
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      flash[:success] = "创建成功！"
      redirect_to admin_teams_path
    else
      flash[:alert] = "创建失败！"
      render 'new'
    end
  end

  def show
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    if @team.update_attributes(team_params)
      flash[:success] = "修改成功！"
      redirect_to admin_teams_path
    else
      flash[:alert] = "修改失败!"
      render admin_team_path(@team)
    end
  end

  def destroy
    @team = Team.find(params[:id])
    if @team.destroy
      flash[:success] = "成功解散队伍！"
    else
      flash[:alert] = "删除失败。你要干什么！？"
    end
    redirect_to admin_teams_path
  end

  private

  def team_params
    params.require(:team).permit(:name, :group, :leader_id)
  end
end
