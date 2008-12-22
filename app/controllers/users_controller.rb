class UsersController < ResourceController::Base
  actions :all, :except => :destroy
  
  create.flash "Account registered!"
  update.flash "Account updated!"
end
