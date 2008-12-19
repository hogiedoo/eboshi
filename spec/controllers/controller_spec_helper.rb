module ControllerSpecHelperMethods
  def setup_env
	  integrate_views
	
	  before(:each) do
		  controller.stub!(:authenticate_or_request_with_http_basic).and_return(true)
		  controller.stub!(:current_user).and_return(Factory :user)
	  end
	end
end
