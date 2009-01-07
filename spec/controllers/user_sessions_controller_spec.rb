require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserSessionsController do
  include ControllerSpecHelpers
  
  describe "should not error out" do
    it "on new" do
    	get :new
		end
		it "on create" do
			User.stub!(:authenticate).and_return User.make
			post :create
		end
		it "on destroy" do
		  controller.stub!(:current_user_session).and_return(mock("current_user_session", :null_object => true))
			get :destroy
		end
  end

end
