class StaticPagesController < ApplicationController
  def home
    @informs = Inform.recent.limit(4)
  end

  def doc
  end

  def about
  end
end
