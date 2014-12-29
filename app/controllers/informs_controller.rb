class InformsController < ApplicationController
  def index
    @informs = Inform.all.order("updated_at DESC").page(params[:page])
  end

  def show
    @inform = Inform.find(params[:id])
  end
end
