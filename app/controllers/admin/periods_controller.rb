# -*- coding: utf-8 -*-
class Admin::PeriodsController < ApplicationController
  def create
    @period = Period.new(period_params)
    if @period.save
      flash[:success] = "添加成功！"
    else
      flash[:alert] = "添加失败！"
    end
    redirect_to admin_event_path(period_params[:event_id])
  end

  def destroy
    @period = Period.find(params[:id])
    @event = @period.event
    
    if @period.destroy
      flash[:success] = "删除成功！"
    else
      flash[:alert] = "删除失败！"
    end
    redirect_to admin_event_path(@event)
  end

  private
  def period_params
    params.require(:period).permit(:event_id, :start_time, :end_time, :total_number)
  end
end
