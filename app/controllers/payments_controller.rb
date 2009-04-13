class PaymentsController < ResourceController::Base
  before_filter :get_invoice
  before_filter :authorized?
  
  actions :new, :create
  
  create.wants.html { redirect_to invoices_path(@invoice.client) }
  
  protected
    def build_object
      @object = @invoice.payments.build(params[:payment] || { :total => @invoice.balance })
    end
    
    def get_invoice
      @invoice ||= Invoice.find params[:invoice_id]
    end
    
    def authorized?
      current_user.authorized? @invoice
    end
end
