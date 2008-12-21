class PaymentsController < ResourceController::Base
  actions :new, :create
  
  create.wants.html { redirect_to invoices_path(@invoice.client) }
  
  protected
    def build_object
      @invoice = Invoice.find params[:invoice_id]
      @object = @invoice.payments.build(params[:payment] || { :total => @invoice.balance })
    end
end
