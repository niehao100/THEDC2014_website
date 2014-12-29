# -*- coding: utf-8 -*-
class MembershipsController < ApplicationController
  include SessionsHelper

  before_action :signed_in_user
  before_action :leader_user

  def create
    @user = User.find(params[:user_id])
    current_user.team.add_member!(@user)
    redirect_to @user
  end

  def destroy
    @user = Membership.find(params[:id]).user
    current_user.team.kick_member!(@user)
    redirect_to edit_team_path(current_user.team)
  end
end
