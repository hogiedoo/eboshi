class WorksController < ResourceController::Base
  include LineItemsControllerMethods

  def clock_in
  	@work = @client.clock_in current_user
  	
		respond_to do |format|
			format.html { redirect_to invoices_path(@client) }
			format.js { render @work }
		end
  end
  
  def clock_out
  	object.clock_out
  	
  	respond_to do |format|
  	  format.html { redirect_to invoices_path(@client) }
  	  format.js do
  	    render :json => {
    	    :work => render_to_string(:partial => object),
          :total => object.invoice_total
        }
      end
  	end
  end
  
  def merge
    puts params.inspect
    @work = Work.merge_from_ids params[:line_item_ids]
    @invoice = @work.invoice || @client.build_invoice_from_unbilled
    respond_to do |format|
      format.html { redirect_to invoices_path(@client) }
      format.js { render @work }
    end
  end

  protected
	  def build_object
      @object ||= @client.works.build params[:work]
      @object.user = current_user
    end
end
