class UsersController < ResourceController::Base
 
  actions :all, :except => :show

  def create
    cookies.delete :auth_token
    @user = User.new(params[:user])
    if @user.save
      self.current_user = @user
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!"
    else
      render :action => 'new'
    end
  end
  
  update.wants.html { redirect_to users_path }

end
