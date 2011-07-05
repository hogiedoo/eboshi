class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new params[:user_session]
    if @user_session.save
      flash[:notice] = "Login successful!"
      if @user_session.user.last_client
        redirect_to invoices_path(@user_session.user.last_client)
      else
        redirect_back_or_default '/'
      end
    else
      render "new"
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to login_path
  end
end
