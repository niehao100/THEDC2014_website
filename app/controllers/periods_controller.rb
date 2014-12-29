# -*- coding: utf-8 -*-
class PeriodsController < ApplicationController
  def add
    @period = Period.find(params[:id])
    @team = Team.find(params[:team_id])
    if @period.addin_team(@team)
      flash[:success] = "加入成功！"
    else
      flash[:alert] = "加入失败！"
    end
    redirect_to event_path(@period.event)
  end

  def remove
    @period = Period.find(params[:id])
    @team = Team.find(params[:team_id])
    if @period.remove_team(@team)
      flash[:success] = "取消成功！"
    else
      flash[:alert] = "取消失败！"
    end
    redirect_to event_path(@period.event)
  end
end
