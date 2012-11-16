module ControllerSpecHelpers
  def self.included(klass)
    klass.instance_eval do
      # integrate_views
      
      before :each do
        @current_user = User.make :business_name => "Micah Geisel"
        @current_user.stub!(:authorized?).and_return(true)
        controller.stub!(:current_user).and_return(@current_user)        
      end
    end
  end
end
