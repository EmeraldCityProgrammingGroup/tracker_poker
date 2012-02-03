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
      p.point_scale = "0,1,2,3,5,8,13,20,40,100"
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
    it "should store a users vote" do
      StoryVote.any_instance.should_receive(:create)#.with({"user_id" => @user.id, "story_id" => @story.id, "score" => 8})
      post "vote", :auth_token => @user.authentication_token, :score => 8, :room_id => @room.id, :id=> @story.id
      response.response_code.should == 200
      response.body.should == "success"
    end
    it "should update a vote if already voted on this story" do
      3.times do |x|
        post "vote", :auth_token => @user.authentication_token, :score => x, :room_id => @room.id, :id=> @story.id
      end
      StoryVote.where(:story_id => @story.id, :room_id => @room.id).count.should == 1
    end
  end
  # votes
  describe "GET 'votes'" do
    before(:each) do
      sign_in @user
      3.times do |x|
        user_x = Factory(:user, :authentication_token =>Digest::MD5.hexdigest("User #{x}\n"))
        post "vote", :auth_token => user_x.authentication_token, :score => x, :room_id => @room.id, :id=> @story.id
      end
    end
    it "should list all votes for a given story" do 
      get 'votes', :room_id => @room.id, :id=> @story.id
      assigns[:votes].count.should == 3
    end
    it "should calculate the average score on a given story" do
      get 'votes', :room_id => @room.id, :id=> @story.id
      assigns[:avg_score].should == 1
    end
    it "should calculate the estimated points for this story" do
      get 'votes', :room_id => @room.id, :id=> @story.id
      assigns[:estimated_score].should == "1"
    end
  end
  # open_voting
  describe "GET 'open_voting'" do
    before(:each) do
      sign_in @user
    end
    it "should set the current_story_id on the room to the current story" do
      get 'open_voting', :room_id => @room.id, :id=> @story.id, :format => "js"
      response.response_code.should == 200
      Room.find(@room.id).current_story_id.should == @story.id
    end
  end
  # close_voting
  describe "GET 'close_voting'"do 
    before(:each) do
      sign_in @user
    end
    it "should set the current_story_id on the room to -1"do
      get 'close_voting', :room_id => @room.id, :id=> @story.id, :format => "js"
      response.response_code.should == 200
      Room.find(@room.id).current_story_id.should == -1
    end
  end
  # status_voting
  describe "GET 'status_voting'" do
    before(:each) do
      sign_in @user
    end
    it "should get the precentage of 0 votes in room"do
      get 'status_voting', :room_id => @room.id, :id=> @story.id
      assigns[:precentage].should == 0
    end
    it "should return presentage of 100 with a vote submited" do
      post "vote", :auth_token => @user.authentication_token, :score => 8, :room_id => @room.id, :id=> @story.id
      get 'status_voting', :room_id => @room.id, :id=> @story.id
      assigns[:precentage].should == 100
    end
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
