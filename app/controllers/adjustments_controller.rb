class AdjustmentsController < ResourceController::Base
  include LineItemsControllerMethods

  protected
	  def build_object
      @object ||= @client.adjustments.build params[:adjustment]
      @object.user = current_user
    end
end
