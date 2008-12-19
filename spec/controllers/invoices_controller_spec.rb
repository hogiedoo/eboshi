require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe InvoicesController do
  fixtures :all
	integrate_views
	
	before(:each) do
		controller.stub!(:authenticate_or_request_with_http_basic).and_return(true)
		controller.stub!(:current_user).and_return(users(:Micah))
		@client = clients(:NANETS)
		@invoice = invoices(:invoice)
	end

  describe "should not error out" do
    it "on index" do
      get :index, :client_id => @client.id
    end
    it "on show" do
      get :show, :id => @invoice.id
    end
    it "on pdf formatted show" do
      get :show, :id => @invoice.id, :format => 'pdf'
    end
    it "on edit" do
      get :edit, :id => @invoice.id
    end
    it "on new" do
      get :new, :client_id => @client.id
    end
    it "on update" do
      put :update, :id => @invoice.id, :invoice => @invoice.attributes
    end
    it "on destroy" do
      delete :destroy, :id => @invoice.id
    end
    it "on create" do
      post :create, :client_id => @client.id, :invoice => @invoice.attributes
    end
    it "on paid" do
      post :paid, :id => @invoice.id
    end
  end
  
  describe "on create" do
    it "should allow adjustment via total field" do
      @client = Factory(:client)
      works = []
      3.times do
        works << Factory(:work)
      end
      attrs = {
        "line_item_ids" => works.collect(&:id),
        "paid" => 0,
        "project_name" => "testing site",
        "total" => works.sum(&:total)+50
      }
      post :create, :client_id => @client.id, :invoice => attrs
      debugger
	    response.should redirect_to(invoices_path(@client))
      assigns(:invoice).should have(:no).errors
      assigns(:invoice).should have(1).adjustments
      assigns(:invoice).adjustments.first.total.should == 50
      assigns(:invoice).total.should == works.sum(&:total)+50
    end
  end

end
