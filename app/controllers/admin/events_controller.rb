# -*- coding: utf-8 -*-
class Admin::EventsController < Admin::BaseController
  def index
    @events = Event.page(params[:page])
  end

  def show
    @event = Event.find(params[:id])
    @duels = @event.duels
    @period = Period.new(event_id: @event.id)
    @periods = @event.periods.order(:start_time)
  end

  def print
    @event = Event.find(params[:id])
    @trials = @event.trials.order(:start_time)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:success] = "添加成功！"
      redirect_to admin_event_path(@event)
    else
      flash[:alert] = "添加失败！"
      render new_admin_event_path
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      flash[:success] = "删除成功！"
    else
      flash[:alert] = "删除失败!"
    end
    redirect_to admin_events_path
  end

  private
  def event_params
    params.require(:event).permit(:name, :description, :due_date)
  end
end
