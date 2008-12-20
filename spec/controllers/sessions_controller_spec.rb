require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SessionsController do
  extend ControllerSpecHelpers
  setup_env
  
  describe "should not error out" do
    it "on new" do
    	get :new
		end
		it "on create" do
			User.stub!(:authenticate).and_return Factory(:user)
			post :create
		end
		it "on destroy" do
			get :destroy
		end
  end

end
