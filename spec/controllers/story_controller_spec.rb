require 'spec_helper'

describe StoryController do
  before(:each) do 
    pu = Factory(:pivotal_user)
    @user = pu.user
    @room = Factory(:room)
    # test << PivotalTracker::Story.new( :id =>11111, :name => "test", :estimate=>-1, :current_state=>"unstarted")
    PivotalTracker::Project.stub(:find).and_return do
      p = PivotalTracker::Project.new
      p.id = 12345 
      p.name = "Hello World"
      p
    end
    @story = PivotalTracker::Story.new(:id => 1, :name=>"unstarted 1", 
          :estimate => -1, :current_state => "unstarted")
    PivotalTracker::Story.stub(:find).and_return(@story)
  end
  
  describe "GET index" do
    before(:each) do
      PivotalTracker::Story.stub(:all).and_return do
        test = []
        test << PivotalTracker::Story.new(:id => 1, :name=>"unstarted 1", 
          :estimate => -1, :current_state => "unstarted")
        test << PivotalTracker::Story.new(:id => 2, :name=>"unstarted 2", 
          :estimate => -1, :current_state => "unstarted")
        test << PivotalTracker::Story.new(:id => 3, :name=>"unstarted 3", 
          :estimate => 13, :current_state => "unstarted")
        test
      end
      sign_in @user
    end
    it "should return a success" do 
      get 'index', :room_id => @room.id
      response.response_code.should == 200
    end
    it "should remove the estimated stories from array" do
      get 'index', :room_id => @room.id
      assigns[:active_count].should == 3
      assigns[:unestimated_count].should == 2
    end
  end
  
  describe "GET icebox" do
    before(:each) do
      PivotalTracker::Story.stub(:all).and_return do
        test = []
        test << PivotalTracker::Story.new(:id => 1, :name=>"unscheduled 1", 
          :estimate => -1, :current_state => "unscheduled")
        test << PivotalTracker::Story.new(:id => 2, :name=>"unscheduled 2", 
          :estimate => -1, :current_state => "unscheduled")
        test << PivotalTracker::Story.new(:id => 3, :name=>"unscheduled 3", 
          :estimate => 13, :current_state => "unscheduled")
        test
      end
      sign_in @user
    end
    it "should return a success" do 
      get 'icebox', :room_id => @room.id
      response.response_code.should == 200
    end
    it "should remove the estimated stories from array" do
      get 'icebox', :room_id => @room.id
      assigns[:active_count].should == 3
      assigns[:unestimated_count].should == 2
    end
  end
  
  describe "POST 'update'" do
    before(:each) do
      @story.stub(:update).and_return(true)
      sign_in @user
    end
    it "should redirect to index on successful update" do
      post 'update', :estimate => 13, :room_id => @room.id, :id=> 1
      response.should redirect_to room_story_index_url(:room_id => @room.id)
    end
    it "should change the esitmate" do
      @story.should_receive(:estimate=).with("13")
      post 'update', :estimate => 13, :room_id => @room.id, :id=> 1
    end
    it "should redirect to show with failure" do
      @story.stub(:update).and_return(false)
      post 'update', :estimate => 13, :room_id => @room.id, :id=> 1
      response.should redirect_to room_story_url(:id => 1, :room_id => @room.id)
    end
  end
  
  describe "GET 'show'" do
    before(:each) do
      sign_in @user
    end
    it "returns http success" do
      get 'show', :room_id => @room.id, :id=> @story.id
      response.should be_success
    end
  end
  
  # vote
  describe "Post 'vote'" do
    it "should store a users vote"
    it "should update a vote if already voted on this story"
  end
  # votes
  describe "GET 'votes'" do
    it "should list all votes for a given story"
    it "should calculate the average score on a given story"
    it "should calculate the estimated points for this story"
  end
  # open_voting
  describe "GET 'open_voting'" do
    it "should set the current_story_id on the room to the current story"
  end
  # close_voting
  describe "GET 'close_voting'"do 
    it "should set the current_story_id on the room to -1"
  end
  # status_voting
  describe "GET 'status_voting'" do
    it "should get the precentage of votes vs registered users in room"
  end
  
  
  # describe "GET 'new'" do
  #   it "returns http success" do
  #     get 'new'
  #     response.should be_success
  #   end
  # end
  # 
  # describe "GET 'create'" do
  #   it "returns http success" do
  #     get 'create'
  #     response.should be_success
  #   end
  # end
  # 
  # 
  # 
  # describe "GET 'edit'" do
  #   it "returns http success" do
  #     get 'edit'
  #     response.should be_success
  #   end
  # end
  # 
  # describe "GET 'destroy'" do
  #   it "returns http success" do
  #     get 'destroy'
  #     response.should be_success
  #   end
  # end
  # 


end
