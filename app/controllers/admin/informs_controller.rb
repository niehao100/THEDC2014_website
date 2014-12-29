# -*- coding: utf-8 -*-
class Admin::InformsController < Admin::BaseController
  def index
    @informs = Inform.all.order("updated_at DESC").page(params[:page])
  end

  def new
    @inform = Inform.new
  end

  def create
    @inform = Inform.new(inform_params)
    if @inform.save
      flash[:success] = "添加成功！"
      redirect_to admin_informs_path
    else
      flash[:alert] = "添加失败！"
      render new_admin_inform_path
    end
  end

  def show
    @inform = Inform.find(params[:id])
  end

  def edit
    @inform = Inform.find(params[:id])
  end

  def update
    @inform = Inform.find(params[:id])
    if @inform.update_attributes(inform_params)
      flash[:success] = "修改成功！"
      redirect_to admin_informs_path
    else
      flash[:alert] = "修改失败!"
      redirect_to admin_inform_path(@inform)
    end
  end

  def destroy
    @inform = Inform.find(params[:id])
    if @inform.destroy
      flash[:success] = "删除成功！"
    else
      flash[:alert] = "删除失败!"
    end
    redirect_to admin_informs_path
  end

  private

  def inform_params
    params.require(:inform).permit(:title, :content)
  end
end
