class InvoicesController < ResourceController::Base
	before_filter :get_invoice, :except => [:index, :new, :create]
	before_filter :get_client
  before_filter :authorized?

	index.before { current_user.update_attribute(:last_client, @client) }
	index.wants.js { render @client.invoices.paid }
	
	show.response do |wants|
	  wants.html { render :layout => false }
	  wants.pdf do
      require 'prince'
      prince = Prince.new()
      prince.add_style_sheets "#{RAILS_ROOT}/public/stylesheets/invoice.css"
      # Set RAILS_ASSET_ID to blank string or rails appends some time after 
      # to prevent file caching, fucking up local - disk requests.
      ENV["RAILS_ASSET_ID"] = ''
      html_string = render_to_string :template => 'invoices/show.html.haml', :layout => false

      # Make all paths relative, on disk paths...
      html_string.gsub!("src=\"", "src=\"#{RAILS_ROOT}/public")
      
      # Send the generated PDF file from our html string.
      send_data(
        prince.pdf_from_string(html_string),
    	  :filename => "bot-and-rose_invoice-#{@invoice.id}.pdf",
        :type => 'application/pdf',
        :disposition => 'inline'
      )
	  end
	end
	show.wants.js { render :partial => 'mini', :locals => { :invoice => @invoice } } 
	edit.wants.js { render :partial => 'full', :locals => { :invoice => @invoice } } 
  create.wants.html { redirect_to invoices_path(@client) }
  update.wants.html { redirect_to invoices_path(@client) }
  destroy.wants.html { redirect_to invoices_path(@client) }

	protected 
		def get_client
			@client ||= @invoice.try(:client) || Client.find(params[:client_id])
		end

		def get_invoice
		  @invoice ||= Invoice.find params[:id]
		end
		
		def build_object
		  if params[:invoice]
		    @object = @client.invoices.build
		    @object.attributes = params[:invoice]
		  else
    		@object = @client.build_invoice_from_unbilled(params[:line_item_ids])
		  end
		end

  private
    def authorized?
			current_user.authorized? @client
    end      
end
