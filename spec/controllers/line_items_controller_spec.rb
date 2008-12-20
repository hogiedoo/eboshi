require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LineItemsController do
  extend ControllerSpecHelpers
  setup_env
  
  before :each do
		@client = Factory :client
		@line_item = Factory :work, :client => @client
	end

  describe "should not error out" do
    it "on edit" do
      get :edit, :client_id => @client.id, :id => @line_item.id
    end
    it "on new" do
      get :new, :client_id => @client.id
    end
    it "on update" do
      put :update, :client_id => @client.id, :id => @line_item.id, :line_item => @line_item.attributes
    end
    it "on destroy" do
      delete :destroy, :client_id => @client.id, :id => @line_item.id
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
		end
    it "on merge" do
      get :merge, :client_id => @client.id, :line_item_ids => @client.works.collect(&:id)
    end  	
  end
end
