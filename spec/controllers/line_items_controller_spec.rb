require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LineItemsController do
  include ControllerSpecHelpers
  
  before :each do
		@client = Factory :client
		@line_item = Factory :work, :client => @client
	end
	
  describe "should not error out" do
    it "on edit" do
      get :edit, :client_id => @client.id, :id => @line_item.id
      response.should be_success
    end
    it "on new" do
      get :new, :client_id => @client.id
      response.should be_success
    end
    it "on update" do
      put :update, :client_id => @client.id, :id => @line_item.id, :line_item => @line_item.attributes
      response.should be_redirect
    end
    it "on shallow update" do
      put :update, :id => @line_item.id, :line_item => @line_item.attributes
      response.should be_redirect
    end
    it "on destroy" do
      delete :destroy, :client_id => @client.id, :id => @line_item.id
      response.should be_redirect
    end
    it "on create" do
      post :create, :client_id => @client.id, :client => @client.attributes
    end

    it "on clock_in" do
      get :clock_in, :client_id => @client.id
    end
		it "on clock_out" do
			@line_item = Factory :work, :start => Date.today, :finish => Date.today
			get :clock_out, :client_id => @client.id, :id => @line_item.id
      response.should be_redirect
		end
    it "on merge" do
      get :merge, :client_id => @client.id, :line_item_ids => @client.works.collect(&:id)
      response.should be_redirect
    end  	
  end
  
  describe "on update" do
    it "should allow update of notes" do
      put :update, :id => @line_item.id, :line_item => { :notes => 'test' }
      assigns(:line_item).should have(:no).errors 
      assigns(:line_item).notes.should == 'test'
      response.should be_redirect
    end
  end
end
