module ApplicationHelper
  def title
    if @title
      result = "Tracker Poker - #{@title}"
    else
      result = "Tracker Poker"
    end
    result
  end
  
  def login_text
    if user_signed_in?
      "Welcome #{current_user.email} | #{link_to 'Sign out', destroy_user_session_path, :method => :delete }".html_safe
    else
      "Welcome Guest | #{link_to "Log-in", new_user_session_path}".html_safe
    end
  end
end
