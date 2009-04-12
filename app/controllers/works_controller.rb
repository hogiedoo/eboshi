class WorksController < ResourceController::Base
	before_filter :get_work, :except => [:new, :create, :clock_in, :merge]
	before_filter :get_client
	before_filter :authorized?

  actions :all, :except => [:index, :show]

  create.wants.html { redirect_to invoices_path(@client) }
  
  update.success do
    wants.html { redirect_to invoices_path(@client) }
    wants.js { render :nothing => true }
  end
  
  update.failure do
    wants.html { render :edit }
    wants.js { exit }
  end

  destroy.wants.html { redirect_to invoices_path(@client) }
  destroy.wants.js { render :json => @work.invoice_total }
  
  def clock_in
  	@work = @client.clock_in current_user
  	
		respond_to do |format|
			format.html { redirect_to invoices_path(@client) }
			format.js { render @work }
		end
  end
  
  def clock_out
  	@work.clock_out
  	
  	respond_to do |format|
  	  format.html { redirect_to invoices_path(@client) }
  	  format.js do
  	    render :json => {
    	    :work => render_to_string(:partial => @work),
          :total => @work.invoice_total
        }
      end
  	end
  end
  
  def merge
    work = Work.merge_from_ids params[:work_ids]
    @invoice = work.invoice || @client.build_invoice_from_unbilled
    respond_to do |format|
      format.html { redirect_to invoices_path(@client) }
      format.js { render @work }
    end
  end

  protected
    def get_work
      @work ||= Work.find params[:id]
    end

  	def get_client
		  @client ||= (@work.try(:client) || Client.find(params[:client_id]))
	  end
	  
	  def build_object
      @object ||= @client.works.build params[:work]
      @object.user = current_user
    end

  private
    def authorized?
			current_user.authorized? @client
    end
end
