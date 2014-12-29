# -*- coding: utf-8 -*-
class AppliesController < ApplicationController
  include SessionsHelper

  before_action :signed_in_user
  before_action :leader_user, only: [:accept, :decline]

  def create
    @team = Team.find(params[:team_id])
    if @team
      current_user.apply_to_team(@team)
      flash[:success] = "成功发送申请"
    else
      flash[:alert] = "申请发送失败"
    end
    redirect_to teams_path
  end

  def accept
    @apply = Apply.find(params[:id])
    if @apply
      @apply.team.add_member!(@apply.user) 
      flash[:success] = "已接受申请"
    else
      flash[:alert] = "申请已失效，接受不成功"
    end
    redirect_to team_path(current_user.team)
  end

  def decline
    @apply = Apply.find(params[:id])
    if @apply
      @apply.decline!
      flash[:success] = "已拒绝申请"
    else
      flash[:alert] = "申请已失效，大概是拒绝了吧"
    end
    redirect_to team_path(current_user.team)
  end

  def cancel
    @apply = Apply.find(params[:id])
    if @apply
      @apply.cancel!
      flash[:success] = "已取消申请"
    else
      flash[:alert] = "取消失败，到底是怎么回事呢？"
    end
    redirect_to team_path(current_user.team)
  end
end
