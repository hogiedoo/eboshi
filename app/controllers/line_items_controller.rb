class LineItemsController < ApplicationController
  before_filter :get_client
  before_filter :authorized?

  def new
    @line_item = LineItem.new
  end

  def create
    @line_item = LineItem.new params[:line_item]
    if @line_item.save
      flash[:notice] = "Line Item successfully created!"
      redirect_to invoices_path(@client)
    else
      render :action => :new
    end
  end

  def edit
    @line_item = LineItem.find params[:id]
  end

  def update
    @line_item = LineItem.find params[:id]
    if @line_item.update_attributes params[:line_item]
      flash[:notice] = "Line Item successfully updated!"
      redirect_to invoices_path(@client)
      respond_to do |wants|
        wants.html { redirect_to invoices_path(@client) }
        wants.js { render :nothing => true }
      end
    else
      respond_to do |wants|
        wants.html { render :edit }
        wants.js { exit }
      end
    end
  end

  def destroy
    @line_item = LineItem.find params[:id]
    @line_item.destroy
    respond_to do |wants|
      wants.html { redirect_to invoices_path(@client) }
      wants.js { render :json => object.invoice_total }
    end
  end


  protected
    def get_client
      @client ||= (@line_item.try(:client) || Client.find(params[:client_id]))
    end

  private
    def authorized?
      current_user.authorized? @client
    end
end
