class ClientsController < ApplicationController
  before_filter :authorized?, :only => [:show, :edit, :update, :destroy]
  
  def index
    @clients = current_user.clients
  end
  # actions :all, :except => :show  

  # create.wants.html { redirect_to clients_path }
  # create.after { object.users << current_user }
  #
  # update.wants.html { redirect_to clients_path }
  
  private
    def authorized?
      current_user.authorized? object
    end
end
