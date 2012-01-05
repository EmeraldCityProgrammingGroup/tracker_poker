class PivotalController < ApplicationController
  def login
  end

  def projects
  end
  
  def stories 

    @project = PivotalTracker::Project.find(params[:project_id].to_i)
    @stories = @project.stories.all :current_state=>"unscheduled"
  end
  
  
end
