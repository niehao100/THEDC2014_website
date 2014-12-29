# -*- coding: utf-8 -*-
class Admin::DocsController < Admin::BaseController
  def index
    @docs = Doc.all.order("created_at DESC").page(params[:page])
  end

  def new
    @doc = Doc.new
  end

  def create
    @doc = Doc.new(doc_params)
    if @doc.save
      flash[:success] = "添加成功！"
      redirect_to admin_docs_path
    else
      flash[:alert] = "添加失败！"
      render new_admin_doc_path
    end
  end

  def show
    @doc = Doc.find(params[:id])
  end

  def update
    @doc = Doc.find(params[:id])
    if @doc.update_attributes(doc_params)
      flash[:success] = "修改成功！"
      redirect_to admin_docs_path
    else
      flash[:alert] = "修改失败!"
      redirect_to admin_doc_path(@doc)
    end
  end

  def destroy
    @doc = Doc.find(params[:id])
    if @doc.destroy
      flash[:success] = "删除成功！"
    else
      flash[:alert] = "删除失败!"
    end
    redirect_to admin_docs_path
  end

  private

  def doc_params
    params.require(:doc).permit(:title, :description, :doc_file)
  end
end
