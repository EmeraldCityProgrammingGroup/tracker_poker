class StoryController < PivotalController
  skip_before_filter :confirm_pivotal!, :only => [:vote]
  
  def new
  end

  def create
  end

  def update
    room_id = params[:room_id]
    @project = PivotalTracker::Project.find(Room.find(params[:room_id]).project_id.to_i)
    @story = @project.stories.find(params[:id].to_i)
    @story.estimate = params[:estimate]
    if @story.update
      redirect_to room_story_index_url(:room_id => room_id), :notice => "Story #{@story.id} saved successful."
    else
      redirect_to room_story_url(:id => @story.id, :room_id => room_id) , :notice => "Could not save estimate"
    end
  end

  def edit
  end

  def destroy
  end

  def index
    @room = Room.find(params[:room_id])
    list_stories @room.project_id, "unstarted"
  end
  def icebox
    @room = Room.find(params[:room_id])
    list_stories @room.project_id, "unscheduled"
    render 'index'
  end
  def show
    @project = PivotalTracker::Project.find(Room.find(params[:room_id]).project_id.to_i)
    @story = @project.stories.find(params[:id].to_i)
  end
  
  def vote
    @room = Room.find(params[:room_id])
    @room.story_votes.create(:user_id => current_user.id, :story_id => params[:id], :score => params[:score])
    render :text => "success"
  end
  
  def votes
    @story_id = params[:id];
    @room = Room.find(params[:room_id])
    @range = PivotalTracker::Project.find(@room.project_id).point_scale.split(',')
    @votes = @room.story_votes.where(:story_id => @story_id)
    sum = 0
    @votes.collect{|vote| sum += vote.score.to_i }
    @avg_score = sum / @votes.count
    @estimated_score = 0 
    @range.each {|x| @estimated_score = x if @avg_score >= x.to_i }
    render :partial=> "votes"
  end
  
  def open_voting
    @room = Room.find(params[:room_id])
    @room.current_story_id = params[:id]
    @room.save
  end
  
  def close_voting
    @room = Room.find(params[:room_id])
    @room.current_story_id = -1
    @room.save
  end
  
  def status_voting
    @room = Room.find(params[:room_id])
    @votes = @room.story_votes.where(:story_id => params[:id])
    counts = @votes.count
    users = @room.users.count
    precentage = counts.to_f / users.to_f * 100.0
    puts "Votes: #{counts} Users: #{users} Precentage: #{precentage}"
    data = {}
    data[:value] = precentage
    # data[:total_vote_count] = @room.users.count
    render :json => data.as_json
  end
end
