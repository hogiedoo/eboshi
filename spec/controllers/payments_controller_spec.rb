require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PaymentsController do
  extend ControllerSpecHelperMethods
  setup_env
	
	it "should not error out on new" do
	  @client = Factory :client
    @invoice = Factory :invoice, :client => @client
	  get :new, :invoice_id => @invoice.id
	end
	
  it "should add a payment to the invoice on create" do
    @invoice = Factory :invoice, :total => 500
    payment_attributes = {
      :total => "50"
    }
    post :create, :invoice_id => @invoice.id, :payment => payment_attributes
    assigns(:invoice).balance.should == 450
  end
  
end
