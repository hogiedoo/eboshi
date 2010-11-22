class ClientsController < ApplicationController
  def index
    @clients = current_user.clients
  end

  def new
    @client = Client.new
  end

  def edit
    @client = current_user.clients.find params[:id]
  end

  def create
    @client = Client.new params[:client]
    if @client.save
      @client.users << current_user
      flash[:notice] = "Client successfully created."
      redirect_to clients_path
    else
      render :new
    end
  end
  
  def update
    @client = current_user.clients.find params[:id], :readonly => false
    if @client.update_attributes params[:client]
      flash[:notice] = "Client successfully updated."
      redirect_to clients_path
    else
      render :edit
    end
  end

  def destroy
    @client = current_user.clients.find params[:id]
    @client.destroy
    redirect_to clients_path
  end
end
