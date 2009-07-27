require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  it "should return a default rate for a client" do
    @user = User.make
    @client = Client.make
    @client.works.make :rate => 60, :start => Date.today - 2.days, :user => @user
    @client.works.make :rate => 70, :start => Date.today + 1.days, :user => @user
    @client.works.make :rate => 50, :start => Date.today - 1.days, :user => @user
    @client.works.make :rate => 100, :start => Date.today + 2.days, :user => User.make
    Client.make.works.make :rate => 120, :start => Date.today + 3.days, :user => @user
    @user.default_rate_for(@client).should == 70
  end

  describe "related_users" do
    it "should return all users that share clients" do
      @client = Client.make
      @it = User.make
      
      @client.users << @it
      3.times { @client.users << User.make }
      2.times { User.make }
      
      @it.related_users.length.should == 3
    end
  end
end
