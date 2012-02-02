require 'spec_helper'

describe RoomController do
  before(:each) do 
    pu = Factory(:pivotal_user)
    @user = pu.user
    @room = Factory(:room)
    # test << PivotalTracker::Story.new( :id =>11111, :name => "test", :estimate=>-1, :current_state=>"unstarted")
    PivotalTracker::Project.stub(:all).and_return do
      test = []
      p = PivotalTracker::Project.new
      p.id = 12345 
      p.name = "Hello World"
      test << p
      test
    end
  end
  
  describe "POST 'join'" do
    it "should allow a user to join a room" do 
      post "join", :auth_token => "e59ff97941044f85df5297e1c302d260", :id => @room.id
      response.body.should == "success"
    end
    it "should allow a user to join a room only one" do
      post "join", :auth_token => "e59ff97941044f85df5297e1c302d260", :id => @room.id
      response.body.should == "success"
      post "join", :auth_token => "e59ff97941044f85df5297e1c302d260", :id => @room.id
      response.response_code.should == 304
    end
    
    it "should not allow you to join a room if you do not have access to project" do
      post "join", :auth_token => "e59ff97941044f85df5297e1c302d260", :id => @room.id
      response.response_code.should == 403
    end
  end
  describe "POST 'active_story'" do
    it "should return the number of the story open for voting" do 
      @room = Factory(:room, :current_story_id => "12345")
      post "active_story", :auth_token => "e59ff97941044f85df5297e1c302d260", :id => @room.id
      response.body.should == "12345"
    end
    it "should return -1 if there is no story open for voting" do 
      post "active_story", :auth_token => "e59ff97941044f85df5297e1c302d260", :id => @room.id
      response.body.should == "-1"
    end
  end
  describe "GET 'new'" do
    before(:each) do
      sign_in @user
    end
    
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end
  # 
  # describe "GET 'create'" do
  #   it "returns http success" do
  #     get 'create'
  #     response.should be_success
  #   end
  # end
  # describe "GET 'show'" do
  #   it "returns http success" do
  #     get 'show'
  #     response.should be_success
  #   end
  # end
  # 
  # describe "GET 'update'" do
  #   it "returns http success" do
  #     get 'update'
  #     response.should be_success
  #   end
  # end
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
  # describe "GET 'index'" do
  #   it "returns http success" do
  #     get 'index'
  #     response.should be_success
  #   end
  # end



end
