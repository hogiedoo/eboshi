class AssignmentsController < ApplicationController
  def new
    @client = current_user.clients.find params[:client_id]
    @assignment = @client.assignments.build :user => current_user
  end

  def create
    @client = current_user.clients.find params[:client_id]
    user = begin 
      User.find(params[:assignment][:user_id])
    rescue ActiveRecord::RecordNotFound
      User.find_by_email(params[:assignment][:email])
    end
    unless user
      flash[:error] = "A user with that email address does not exist!"
      redirect_to new_assignment_path(@client)
    else
      @client.users << user
      flash[:notice] = "Successfully created!"
      redirect_to invoices_path(@client)
    end
  end

  def destroy
    @assignment = Assignment.find params[:id]
    raise ActiveRecord::RecordNotFound unless current_user.clients.include? @assignment.client
    @assignment.destroy
    path = @assignment.user == current_user ? "/" : :back
    redirect_to path
  end
end
