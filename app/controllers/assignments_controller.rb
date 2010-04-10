class AssignmentsController < ApplicationController
  before_filter :get_client, :only => [:new, :create]
  before_filter :authorized?
  
  def new
    @assignment = Assignment.new
  end

  def create
    user = begin 
      User.find(params[:assignment][:user_id])
    rescue ActiveRecord::RecordNotFound
      User.find_by_email(params[:assignment][:email])
    end
    unless user
      flash[:error] = "A user with that email address does not exist!"
      redirect_to new_assignment_path
    else
      @client.users << user
      flash[:notice] = "Successfully created!"
      redirect_to invoices_path(@client)
    end
  end

  def destroy
    @assignment = Assignment.find params[:id]
    @assignment.destroy
    path = object.user == current_user ? "/" : :back
    redirect_to path
  end
  
  private
    def get_client
      @client ||= Client.find params[:client_id]
    end
    
    def authorized?
      current_user.authorized? object || @client
    end
end
