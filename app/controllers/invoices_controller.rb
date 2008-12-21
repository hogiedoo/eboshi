class InvoicesController < ResourceController::Base
	before_filter :get_invoice, :except => [:index, :new, :create]
	before_filter :get_client
	
	index.wants.js { render :partial => 'invoice', :collection => @client.invoices.paid }
	
  show.wants.pdf do
		send_data InvoiceDrawer.draw(@invoice),
		  :filename => "bot-and-rose_invoice-#{@invoice.id}.pdf",
		  :type => 'application/pdf',
		  :disposition => 'inline'
	end
	
	edit.wants.js { render :partial => 'full', :locals => { :invoice => @invoice } } 
  create.wants.html { redirect_to invoices_path(@client) }
  update.wants.html { redirect_to invoices_path(@client) }
  destroy.wants.html { redirect_to invoices_path(@client) }

	protected 
		def get_client
			@client = @invoice.try(:client) || Client.find(params[:client_id])
		end

		def get_invoice
		  @invoice = Invoice.find params[:id]
		end
		
		def build_object
		  if params[:invoice]
		    @object = @client.invoices.build
		    @object.attributes = params[:invoice]
		  else
    		@object = @client.build_invoice_from_unbilled(params[:line_item_ids])
		  end
		end

end
