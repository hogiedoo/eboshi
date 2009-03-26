class ClientsController < ResourceController::Base
  before_filter :authorized?, :only => [:show, :edit, :update, :destroy]
  
  actions :all, :except => :show  

  create.wants.html { redirect_to clients_path }
  create.after { object.users << current_user }
  
  update.wants.html { redirect_to clients_path }
  
  private
    def object
      @object ||= Client.find params[:id]
    end
    
    def collection
      @collection ||= current_user.clients
    end

    def authorized?
      current_user.authorized? object
    end
end
