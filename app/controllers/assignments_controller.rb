class AssignmentsController < ResourceController::Base
  before_filter :authorized?
  
  actions :destroy
  destroy.wants.html do
    path = object.user == current_user ? "/" : :back
    redirect_to path
  end
  
  private
    def authorized?
      current_user.authorized? object
    end
end
