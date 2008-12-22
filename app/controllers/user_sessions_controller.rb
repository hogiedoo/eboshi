class UserSessionsController < ResourceController::Base
  actions :new, :create, :destroy
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  create do
    flash "Login successful!"
    wants.html do
      if object.user.last_client
        redirect_to invoices_path(object.user.last_client)
      else
        redirect_back_or_default '/'
      end
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to login_path
  end
end
