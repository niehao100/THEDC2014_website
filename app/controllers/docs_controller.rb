class DocsController < ApplicationController
  def index
    @docs = Doc.all.order("created_at DESC").page(params[:page])
  end
end
