# -*- coding: utf-8 -*-
class Admin::TrialsController < ApplicationController
  def create
    @trial = Trial.new(trial_params)
    if @trial.save
      flash[:success] = "添加成功！"
    else
      flash[:alert] = "添加失败！"
    end
    redirect_to admin_event_path(trial_params[:event_id])
  end

  def revert
    @trial = Trial.find(params[:id])
    @trial.update_attribute("passed", (!@trial.passed))
    if @trial.passed
      @trial.team.survive
      flash[:success] = "存活！"
    else
      @trial.team.out
      flash[:success] = "阵亡！"
    end
    redirect_to admin_event_path(@trial.period.event)
  end

  def destroy
    @trial = Trial.find(params[:id])
    @event = @trial.period.event
    
    if @trial.destroy
      flash[:success] = "删除成功！"
    else
      flash[:alert] = "删除失败！"
    end
    redirect_to admin_event_path(@event)
  end

  private
  def trial_params
    params.require(:trial).permit(:event_id, :start_time, :end_time, :total_number)
  end
end
