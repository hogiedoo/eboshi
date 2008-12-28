class LineItemsController < ResourceController::Base
  actions :all, :except => [:index, :show]
	before_filter :get_line_item, :except => [:new, :create, :clock_in, :merge]
	before_filter :get_client

  def update
    attributes = params[:line_item] || params[@line_item.class.to_s.underscore]
    if @line_item.update_attributes attributes
      flash[:notice] = "#{@line_item.class.to_s} was successfully updated."
      respond_to do |format|
        format.html { redirect_to invoices_path(@client) }
        format.js { render :nothing => true }
      end
    else
      respond_to do |format|
        format.html { render :action => "edit" }
        format.js { exit }
      end
    end
  end

  destroy.wants.html { redirect_to invoices_path(@client) }
  destroy.wants.js { render :json => @line_item.invoice_total }
  
  def clock_in
  	@line_item = @client.clock_in current_user
  	
		respond_to do |format|
			format.html { render :action => 'new' }
			format.js { render :partial => 'line_item', :object => @line_item }
		end
  end
  
  def clock_out
  	@line_item.clock_out
  	
  	respond_to do |format|
  	  format.html { redirect_to invoices_path(@client) }
  	  format.js do
  	    render :json => {
    	    :line_item => render_to_string(:partial => 'line_item', :object => @line_item),
          :total => @line_item.invoice_total
        }
      end
  	end
  end
  
  def merge
    work = Work.merge_from_ids params[:line_item_ids]
    @invoice = work.invoice || @client.build_invoice_from_unbilled
    respond_to do |format|
      format.html { redirect_to invoices_path(@client) }
      format.js { render :partial => 'line_item', :locals => { :line_item => work } }
    end
  end

  protected
    def get_line_item
      @line_item = LineItem.find params[:id]
    end

  	def get_client
		  @client = @line_item.try(:client) || Client.find(params[:client_id])
	  end
	  
	  def build_object
      @object = @client.line_items.build params[:line_item]
    end

end
