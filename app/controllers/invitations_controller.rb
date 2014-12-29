# -*- coding: utf-8 -*-
class InvitationsController < ApplicationController
  include SessionsHelper

  before_action :signed_in_user
  before_action :leader_user, only: [:create, :cancel, :destroy]

  def create
    @user = User.find(params[:user_id])
    if @user
      current_user.team.invite_member(@user)
      flash[:success] = "成功发送邀请"
    else
      flash[:alert] = "邀请发送失败 没有这个选手"
    end
    redirect_to users_path
  end

  def accept
    @invitation = Invitation.find(params[:id])
    if @invitation
      @invitation.team.add_member!(@invitation.user) 
      flash[:success] = "已接受邀请"
    else
      flash[:alert] = "邀请已失效，接受不成功"
    end
    redirect_to user_path(current_user)
  end

  def decline
    @invitation = Invitation.find(params[:id])
    if @invitation
      @invitation.decline!
      flash[:success] = "已拒绝邀请"
    else
      flash[:alert] = "邀请已失效，大概是拒绝了吧"
    end
    redirect_to user_path(current_user)
  end

  def cancel
    @invitation = Invitation.find(params[:id])
    if @invitation
      @invitation.cancel!
      flash[:success] = "已取消邀请"
    else
      flash[:alert] = "取消失败，到底是怎么回事呢？"
    end
    redirect_to team_path(current_user.team)
  end

  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation.destroy
    redirect_to team_path(current_user.team)
  end
end
