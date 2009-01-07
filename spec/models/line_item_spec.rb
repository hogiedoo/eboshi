require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LineItem do
  it "should be able to set the total manually" do
    @line_item = Work.make
    @line_item.total = 200
    @line_item.total.should == 200
  end
  
  it "should be able to set user name manually" do
    @line_item = Work.make
    @user = User.make
    @line_item.user_name = @user.name
    @line_item.user.should eql @user
  end
  
  it "should return invoice total if billed" do
    @invoice = Invoice.make
    @billed = Work.make :invoice => @invoice
    @billed.invoice_total.should eql @invoice.total
  end
  
  it "should return client balance if unbilled" do
    @client = Client.make
    @unbilled = Work.make :client => @client, :invoice => nil
    @unbilled.invoice_total.should eql @client.balance
  end
end
