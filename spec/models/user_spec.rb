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

  describe "totals by date" do
    before do
      @it = User.make
      @it.works.make :rate => 60, :start => Date.today, :finish => Date.today + 1.hour
      @it.works.make :rate => 70, :start => Date.today, :finish => Date.today + 1.hour
      @it.works.make :rate => 50, :start => Date.today, :finish => Date.today + 1.hour
    end

    it "should return the total money earned" do
      @it.total_by_date(Date.today).should == 180.0
    end

    it "should return the total hours" do
      @it.hours_by_date(Date.today).should == 3
    end
  end

  describe "totals by month" do
    before do
      @it = User.make
      @it.works.make :rate => 60, :start => Time.parse("1983-06-10 12:00:00"), :finish => Time.parse("1983-06-10 13:00:00")
      @it.works.make :rate => 70, :start => Time.parse("1983-06-11 12:00:00"), :finish => Time.parse("1983-06-11 13:00:00")
      @it.works.make :rate => 50, :start => Time.parse("1983-06-12 12:00:00"), :finish => Time.parse("1983-06-12 13:00:00")
    end

    it "should return the total money earned" do
      @it.total_by_month(Date.parse("1983-06-19")).should == 180.0
    end

    it "should return the total hours" do
      @it.hours_by_month(Date.parse("1983-06-19")).should == 3
    end
  end

  describe "shouldnt fuck up when encountering times without zones" do
    before do
      @it = User.make
      @it.works.make :rate => 60, :start => Time.zone.parse("1983-12-31 22:00:00"), :finish => Time.zone.parse("1984-01-01 00:00:00")
    end

    it "on total by date" do
      @it.total_by_date(Date.parse("1983-12-31")).should == 120.0
    end

    it "on hours by date" do
      @it.hours_by_date(Date.parse("1983-12-31")).should == 2
    end

    it "on total by month" do
      @it.total_by_month(Date.parse("1983-12-19")).should == 120.0
    end

    it "on hours by month" do
      @it.hours_by_month(Date.parse("1983-12-19")).should == 2
    end
  end

  describe "shouldnt fuck up when encountering times with zones" do
    before do
      @it = User.make
      @it.works.make :rate => 60, :start => Time.zone.parse("1983-01-01 02:00:00"), :finish => Time.zone.parse("1983-01-01 04:00:00")
    end

    it "on total by date" do
      @it.total_by_date(Time.zone.parse("1983-01-01")).should == 120.0
    end

    it "on hours by date" do
      @it.hours_by_date(Time.zone.parse("1983-01-01")).should == 2
    end

    it "on total by month" do
      @it.total_by_month(Time.zone.parse("1983-01-19")).should == 120.0
    end

    it "on hours by month" do
      @it.hours_by_month(Time.zone.parse("1983-01-19")).should == 2
    end
  end
end
