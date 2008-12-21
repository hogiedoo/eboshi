class ClientsController < ResourceController::Base
  actions :all, :except => :show  

  create.wants.html { redirect_to clients_path }
  update.wants.html { redirect_to clients_path }

end
