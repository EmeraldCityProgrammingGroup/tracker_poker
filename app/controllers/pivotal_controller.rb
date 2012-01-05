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
    token = PivotalTracker::Client.token(username, password)   
    current_user.pivotal_users.create :token => token
    unless token.nil?
      redirect_to :pivotal_projects
    else
      redirect_to :povital
    end
  end

  def projects
    @projects = PivotalTracker::Project.all 
  end
  
  def stories 

    @project = PivotalTracker::Project.find(params[:project_id].to_i)
    @stories = @project.stories.all :current_state=>"unscheduled"
  end
  
  
end
