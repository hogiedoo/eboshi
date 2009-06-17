class UsersController < ResourceController::Base
  before_filter :require_admin, :only => :index
  actions :all, :except => :destroy

  create.flash "Account registered!"
  update.flash "Account updated!"
  update.wants.html { redirect_to root_path }
end
