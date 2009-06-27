class AdjustmentsController < ResourceController::Base
  include LineItemsControllerMethods

  before_filter :only => [:create, :update] do |controller|
    if controller.params[:adjustment].delete(:no_date) == "1"
      controller.params[:adjustment][:start] = nil 
      controller.params[:adjustment].delete_if { |key, value| key =~ /^start\(.i\)$/ }
    end
  end

  protected
    def build_object
      @object ||= @client.adjustments.build params[:adjustment]
      @object.user = current_user
    end
end
