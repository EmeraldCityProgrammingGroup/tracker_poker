class RoomController < PivotalController
  def new
    @projects = PivotalTracker::Project.all 
  end

  def create
    @room = Room.new :project_id => params[:project_id], :current_story_id => -1
    if @room.save
      redirect_to room_path(:id => @room.id), :notice => "Room created successfully"
    else
      redirect_to new_room_path, :notice => "Could not create room"
    end
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def index
  end

  def show
    @room = Room.find(params[:id])
  end
  
  def active_story
    @room = Room.find(params[:id])
    render :json => @room.current_story_id
  end
  
  def join
    
  end

end
