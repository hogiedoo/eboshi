require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  describe "related_users" do
    it "should return all users that share clients" do
      @client = Client.make
      @it = User.make
      
      @client.users << @it
      3.times { @client.users << User.make }
      2.times { User.make }
      
      @it.related_users.count.should == 3
    end
  end
end
