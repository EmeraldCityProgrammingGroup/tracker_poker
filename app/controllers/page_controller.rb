class PageController < ApplicationController
  skip_before_filter :authenticate_user!
  def index
    @title = "Home"
  end

  def about
  end

  def contact
    @title = "Contact us"
  end
  def apps
    @title = "Mobile Apps"
  end
end
