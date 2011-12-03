class PageController < ApplicationController
  def index
    @title = "Home"
  end

  def about
  end

  def contact
    @title = "Contact us"
  end

end
