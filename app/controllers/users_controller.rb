class UsersController < ResourceController::Base
  actions :all, :except => :destroy
  
  index.before do
    return head :forbidden unless current_user.admin?
  end
  
  create.flash "Account registered!"
  update.flash "Account updated!"
end
