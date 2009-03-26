class AssignmentsController < ResourceController::Base
  before_filter :authorized?
  
  actions :destroy
  destroy.wants.html { redirect_to :back }
  
  private
    def authorized?
      current_user.authorized? object
    end
end
