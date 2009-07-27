module LineItemsControllerMethods
  def self.included(klass)
    klass.class_eval do
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
      destroy.wants.js { render :json => object.invoice_total }
    end
  end

  protected
  def get_client
    @client ||= (object.try(:client) || Client.find(params[:client_id]))
  end

  private
  def authorized?
    current_user.authorized? @client
  end
end
