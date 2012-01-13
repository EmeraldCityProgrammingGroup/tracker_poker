class StoryController < PivotalController
  def new
  end

  def create
  end

  def update
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
    @story = Story.find(params[:id])
  end
  
  def vote
    @room = Room.find(params[:room_id])
    @room.story_votes.create(:user_id => params[:user_id], :story_id => params[:id], :score => params[:score])
    render :json => "success"
  end
  
  def votes
    @room = Room.find(params[:room_id])
    @room.current_story_id = -1
    @room.save
    @votes = @room.story_votes.where(:story_id => params[:id])
    
  end
  
  def open_voting
    @room = Room.find(params[:room_id])
    @room.current_story_id = params[:id]
    @room.save
  end
end
