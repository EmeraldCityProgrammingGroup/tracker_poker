class PivotalController < ApplicationController
  def index
    unless current_user.pivotal_users.empty?
      PivotalTracker::Client.token = current_user.pivotal_users.last.token
      redirect_to :pivotal_projects
    end
  end
  
  def login
    username = params[:user_name]
    password = params[:password]
    PivotalTracker::Client.token = nil
    token = PivotalTracker::Client.token(username, password)   
    
    unless token.nil?
      current_user.pivotal_users.create :token => token
      redirect_to :pivotal_projects
    else
      redirect_to :pivotal
    end
  end

  def projects
    @projects = PivotalTracker::Project.all 
  end
  
  def stories 
    list_stories "unstarted"
    
  end
  def ice_box
    list_stories "unscheduled"
    render "stories"
  end
  private 
  
  def list_stories(state)
    @project = PivotalTracker::Project.find(params[:project_id].to_i)
    # @stories = @project.stories.all( :current_state=>"unscheduled").map{|x| x if x.estimate == -1}.compact
    @stories = @project.stories.all( :current_state=> state) # list stories moved out of the icebox
    @active_count = @stories.size
    @stories = @stories.collect{|x| x if x.estimate == -1}.compact
    @unestimated_count = @stories.size
  end
end
