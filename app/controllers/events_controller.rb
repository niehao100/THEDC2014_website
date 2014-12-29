class EventsController < ApplicationController
  def index
    @events = Event.page(params[:page])
  end

  def show
    @event = Event.find(params[:id])
    @periods = @event.periods
  end
end
