require 'spec_helper'

describe TokenController do
  before(:each) do
    @user = Factory(:user)
  end
  describe "POST 'fetch'" do
    it "should return token of user loging in" do
      post 'fetch', :user_name => @user.email, :password => @user.password
      response.should be_success
      response.body.should == @user.authentication_token
    end
    it "should return a 403 if not a valid user" do
      post 'fetch', :user_name => @user.email, :password => "pain"
      response.response_code.should == 403
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'delete'" do
    it "returns http success" do
      get 'delete'
      response.should be_success
    end
  end

end
