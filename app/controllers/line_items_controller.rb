class LineItemsController < ResourceController::Base
	before_filter :get_line_item, :except => [:new, :create, :clock_in, :merge]
	before_filter :get_client
	before_filter :authorized?

  actions :all, :except => [:index, :show]

  def update
    class_name = @line_item.class.to_s
    attributes = params[:line_item] || params[class_name.underscore]
    if @line_item.update_attributes attributes
      flash[:notice] = "#{class_name} was successfully updated."
      respond_to do |format|
        format.html { redirect_to invoices_path(@client) }
        format.js { render :nothing => true }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.js { exit }
      end
    end
  end

  destroy.wants.html { redirect_to invoices_path(@client) }
  destroy.wants.js { render :json => @line_item.invoice_total }
  
  def clock_in
  	@line_item = @client.clock_in current_user
  	
		respond_to do |format|
			format.html { redirect_to invoices_path(@client) }
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
      @line_item ||= LineItem.find params[:id]
    end

  	def get_client
		  @client ||= (@line_item.try(:client) || Client.find(params[:client_id]))
	  end
	  
	  def build_object
      @object ||= @client.line_items.build params[:line_item]
    end

  private
    def authorized?
			current_user.authorized? @client
    end
end
