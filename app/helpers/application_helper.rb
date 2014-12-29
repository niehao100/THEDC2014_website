# -*- coding: utf-8 -*-
module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "第16届清华电子设计大赛"
    if page_title.empty?
      base_title= "第16届清华电子设计大赛"

    else
      "#{base_title} | #{page_title}"
    end
  end
end
