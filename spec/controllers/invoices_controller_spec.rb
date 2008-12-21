require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe InvoicesController do
  include ControllerSpecHelpers
  
  describe "should not error out" do
    before :each do
      @client = Factory :client
      @invoice = Factory :invoice, :client => @client
      5.times { Factory :work, :invoice => @invoice }
    end
    
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
    it "on js edit" do
      get :edit, :id => @invoice.id, :format => 'js'
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
  end
  
  describe "on create" do
    it "should allow adjustment via total field" do
      @client = Factory :client
      3.times { Factory :work, :client => @client }
      total = @client.works.to_a.sum(&:total)+50
      attrs = {
        "line_item_ids" => @client.works.collect(&:id),
        "project_name" => "testing site",
        "total" => total
      }
      post :create, :client_id => @client.id, :invoice => attrs
	    response.should redirect_to(invoices_path(@client))
      assigns(:invoice).should have(:no).errors
      assigns(:invoice).should have(1).adjustments
      assigns(:invoice).adjustments.first.total.should == 50
      assigns(:invoice).total.should == total
    end
  end

end
