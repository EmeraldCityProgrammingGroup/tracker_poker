module ApplicationHelper
  def title
    if @title
      result = "Tracker Poker - #{@title}"
    else
      result = "Tracker Poker"
    end
    result
  end
end
