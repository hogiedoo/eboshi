class AssignmentsController < ResourceController::Base
  before_filter :get_client, :only => [:new, :create]
  before_filter :authorized?
  
  actions :new, :create, :destroy
  
  def create
    @client.users << User.find(params[:assignment][:user_id])
    flash[:notice] = "Successfully created!"
    redirect_to invoices_path(@client)
  end

  destroy.wants.html do
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
