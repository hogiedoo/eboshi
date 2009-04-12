class LineItemsController < ResourceController::Base
  actions :update
  
  update.success do
    wants.html { redirect_to invoices_path(@client) }
    wants.js { render :nothing => true }
  end
end
