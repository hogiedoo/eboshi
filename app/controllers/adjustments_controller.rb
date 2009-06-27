class AdjustmentsController < ResourceController::Base
  include LineItemsControllerMethods

  before_filter [:filter_date, :filter_user], :only => [:create, :update]

  protected
    def build_object
      @object ||= @client.adjustments.build params[:adjustment]
    end

    def filter_date
      a = params[:adjustment]
      if a.delete(:no_date) == "1"
        a[:start] = nil 
        a.delete_if { |key, value| key =~ /^start\(.i\)$/ }
      end
    end

    def filter_user
      a = params[:adjustment]
      a[:user_id] = current_user.id if a[:user_id].blank?
      a[:user_id] = nil if a.delete(:no_user) == "1"
    end
end
