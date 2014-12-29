module DuelsHelper
  def duel_a_bg(duel)
    if duel.event.finished?
      if duel.a_win?
        return "class=\"winner\"".html_safe
      else
        return "class=\"loser\"".html_safe
      end
    end
  end
  def duel_b_bg(duel)
    if duel.event.finished?
      if duel.b_win?
        return "class=\"loser\"".html_safe
      else
        return "class=\"loser\"".html_safe
      end
    end
  end
end
