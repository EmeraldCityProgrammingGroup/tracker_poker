class PivotalController < ApplicationController
  before_filter :confirm_pivotal!, :except =>[:login_pivotal, :auth_pivotal]
  
  def login_pivotal
    render "index"
  end
  
  def auth_pivotal
    username = params[:user_name]
    password = params[:password]
    PivotalTracker::Client.token = nil
    token = PivotalTracker::Client.token(username, password) 
    unless token.nil?
      current_user.pivotal_users.create :token => token
      redirect_to session[:last_path]
    else
      redirect_to :pivotal, :notice => "Login Failed"
    end
  end

  # def projects
  #   
  # end
  # 
  # def stories 
  #   list_stories "unstarted"
  #   
  # end
  # def ice_box
  #   list_stories "unscheduled"
  #   render "stories"
  # end 
  protected 
  
  def list_stories(project_id, state)
    @project = PivotalTracker::Project.find(project_id.to_i)
    # @stories = @project.stories.all( :current_state=>"unscheduled").map{|x| x if x.estimate == -1}.compact
    @stories = @project.stories.all( :current_state=> state) # list stories moved out of the icebox
    @active_count = @stories.size
    @stories = @stories.collect{|x| x if x.estimate == -1}.compact
    @unestimated_count = @stories.size
  end
  
  def confirm_pivotal!
    unless current_user.pivotal_users.empty?
      PivotalTracker::Client.token = current_user.pivotal_users.last.token
    else
      session[:last_path] = request.fullpath
      redirect_to :pivotal
    end
  end
end
