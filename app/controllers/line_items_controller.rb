class LineItemsController < ApplicationController
  before_filter :get_client
  before_filter :authorized?

  def update
    @line_item = LineItem.find params[:id]
    if @line_item.update_attributes params[:line_item]
      flash[:notice] = "Line Item successfully updated!"
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


  protected
    def get_client
      @client ||= (@line_item.try(:client) || Client.find(params[:client_id]))
    end

  private
    def authorized?
      current_user.authorized? @client
    end
end
