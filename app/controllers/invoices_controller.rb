class InvoicesController < ApplicationController
  before_filter :get_client
  before_filter :authorized?

  def index
    @invoices = @client.invoices_with_unbilled
    current_user.update_attribute(:last_client, @client)
    respond_to do |wants|
      wants.html
      wants.js { render @client.invoices.paid }
    end
  end

  def show
    @invoice = Invoice.find params[:id]
    respond_to do |wants|
      wants.html { render :layout => false }
      wants.js { render :partial => 'mini', :locals => { :invoice => @invoice } } 
      wants.pdf do
        require 'prince'
        prince = Prince.new()
        prince.add_style_sheets "#{RAILS_ROOT}/public/stylesheets/invoice.css"
        # Set RAILS_ASSET_ID to blank string or rails appends some time after 
        # to prevent file caching, fucking up local - disk requests.
        ENV["RAILS_ASSET_ID"] = ''
        html_string = render_to_string :template => 'invoices/show.html.haml', :layout => false

        # Make all paths relative, on disk paths...
        html_string.gsub!("src=\"", "src=\"#{RAILS_ROOT}/public") unless Rails.env == "production"
        
        # Send the generated PDF file from our html string.
        send_data(
          prince.pdf_from_string(html_string),
          :filename => "#{current_user.business_name_or_name.parameterize}_invoice-\##{@invoice.id}.pdf",
          :type => 'application/pdf',
          :disposition => 'inline'
        )
      end
    end
  end

  def new
    @invoice = @client.build_invoice_from_unbilled(params[:line_item_ids])
  end

  def create
    @invoice = @client.invoices.build params[:invoice]
    if @invoice.save
      flash[:notice] = "Invoice successfully created."
      redirect_to invoices_path(@client)
    else
      render :new
    end
  end

  def edit
    @invoice = Invoice.find params[:id]
    respond_to do |wants|
      wants.html
      wants.js { render :partial => 'full', :locals => { :invoice => @invoice } } 
    end
  end

  def update
    @invoice = Invoice.find params[:id]
    if @invoice.update_attributes params[:invoice]
      flash[:notice] = "Invoice successfully updated."
      redirect_to invoices_path(@client)
    else
      render :edit
    end
  end

  def destroy
    @invoice = Invoice.find params[:id]
    @invoice.destroy
    redirect_to invoices_path(@client)
  end

  private
    def get_client
      @client ||= if params[:client_id]
        Client.find params[:client_id], :include => :assignments
      else
        object.client
      end
    end

    def authorized?
      current_user.authorized? @client
    end      
end
