class PaymentsController < ApplicationController
  before_filter :get_invoice
  
  def new
    @payment = @invoice.payments.build :total => @invoice.balance
  end
  
  def create
	  @payment = @invoice.payments.build(params[:payment])
	  if @payment.save
	    flash[:notice] = 'Payment was successfully created.'
      redirect_to invoices_path(@invoice.client)
	  else
	    render :action => "new"
	  end
  end
  
  protected
    def get_invoice
      @invoice = Invoice.find params[:invoice_id]
    end
end
