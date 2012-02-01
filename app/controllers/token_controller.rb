class TokenController < ApplicationController
  skip_before_filter :authenticate_user!, :only =>[:fetch]
  def fetch
    @user = User.authenticate(params[:username], params[:password])
    unless @user.nil?
      if @user.authentication_token.nil?
        @user.reset_authentication_token!
      end
      render :text => @user.authentication_token
    else
      render :text => "Failed token", :status => 403
    end
  end

  def create
    @user = User.criteria.id(params[:user_id]).first
    @user.reset_authentication_token!
    redirect_to edit_user_registration_path(@user)
  end

  def delete
    @user = User.criteria.id(params[:id]).first
    @user.authentication_token = nil
    @user.save
    redirect_to edit_user_registration_path(@user)
  end

end
