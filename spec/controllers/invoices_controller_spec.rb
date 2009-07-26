require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe InvoicesController do
  include ControllerSpecHelpers

  describe "should not error out" do
    before :each do
      @client = Client.make
      @invoice = @client.invoices.make
      @invoice.works.make :client => @client, :user => @current_user
      @invoice.adjustments.make :client => @client
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

  it "should name the pdf correctly" do
    @client = Client.make
    @invoice = @client.invoices.make :id => 123
    @invoice.works.make :client => @client, :user => @current_user
    @invoice.adjustments.make :client => @client
    get :show, :id => @invoice.id, :format => 'pdf'
    response.headers["Content-Disposition"].should =~ /micah-geisel_invoice-\#123\.pdf/
    response.should be_success
  end

end
