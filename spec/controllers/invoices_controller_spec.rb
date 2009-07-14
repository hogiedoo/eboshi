require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe InvoicesController do
  include ControllerSpecHelpers
  
  describe "should not error out" do
    before :each do
      @client = Client.make
      @invoice = Invoice.make :client => @client
      5.times { Work.make :invoice => @invoice }
      Adjustment.make :invoice => @invoice
    end
    
    it "on index" do
      get :index, :client_id => @client.id
      response.should be_success
    end
    it "on new" do
      get :new, :client_id => @client.id
      response.should be_success
    end
    
    it "on show" do
      get :show, :id => @invoice.id
      response.should be_success
    end
    it "on js show" do
      get :show, :id => @invoice.id, :format => 'js'
      response.should be_success
    end
    it "on pdf show" do
      get :show, :id => @invoice.id, :format => 'pdf'
      response.should be_success
    end
    
    it "on edit" do
      get :edit, :id => @invoice.id
      response.should be_success
    end
    it "on js edit" do
      get :edit, :id => @invoice.id, :format => 'js'
      response.should be_success
    end
    
    it "on create" do
      post :create, :client_id => @client.id, :invoice => @invoice.attributes
      response.should be_redirect
    end
    it "on update" do
      put :update, :id => @invoice.id, :invoice => @invoice.attributes
      response.should be_redirect
    end
    it "on destroy" do
      delete :destroy, :id => @invoice.id
      response.should be_redirect
    end
  end

  it "should escape notes" do
    w = Work.make :invoice => nil, :notes => "test & test"
    get :index, :client_id => w.client.id
    response.body.should match /test &amp; test/
  end

  it "should name the pdf correctly" do
    @client = Client.make
    @invoice = Invoice.make :client => @client, :id => 123
    5.times { Work.make :invoice => @invoice }
    Adjustment.make :invoice => @invoice
    get :show, :id => @invoice.id, :format => 'pdf'
    response.headers["Content-Disposition"].should =~ /micah-geisel_invoice-\#123\.pdf/
  end
  
  describe "on create" do
    it "should allow adjustment via total field" do
      @client = Client.make
      3.times { Work.make :client => @client }
      total = @client.works.to_a.sum(&:total)+50
      attrs = {
        "line_item_ids" => @client.works.collect(&:id),
        "project_name" => "testing site",
        "total" => total
      }
      post :create, :client_id => @client.id, :invoice => attrs
      assigns(:invoice).should have(:no).errors
	    response.should redirect_to(invoices_path(@client))
      assigns(:invoice).should have(1).adjustments
      assigns(:invoice).adjustments.first.total.should == 50
      assigns(:invoice).total.should == total
    end
  end

end
