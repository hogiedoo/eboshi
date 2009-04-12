class UsersController < ResourceController::Base
  actions :all, :except => :destroy

  downloads_files_for :user, :logo
  
  index.before do
    return head :forbidden unless current_user.admin?
  end
  
  create.flash "Account registered!"
  update.flash "Account updated!"
  update.wants.html { redirect_to edit_user_path(current_user) }
end
