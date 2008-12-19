require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Invoice do
  it "should create a new instance given valid attributes" do
    Invoice.create! Factory.attributes_for(:invoice)
  end
  
  it "should not be paid if there are no payments" do
    @invoice = Factory :invoice
    2.times { Factory :work, :invoice => @invoice, :rate => 50, :total => 100 }
    @invoice.balance.should == 200
    @invoice.should_not be_paid
  end
  
  it "unpaid scope should return unpaid invoices and partially paid invoices" do
    @unpaid = Factory :invoice
    3.times { Factory(:work, :invoice => @unpaid) }
    
    @partpaid = Factory :invoice
    3.times { Factory(:work, :invoice => @partpaid) }
    @partpaid.payments << Payment.new(:total => 50)
    
    @paid = Factory :invoice
    3.times do
      Factory(:work, :invoice => @paid)
      @paid.payments << Payment.new(:total => 50)
    end
    
    Invoice.unpaid.should have(2).invoices
    Invoice.unpaid.should include(@unpaid, @partpaid)
    Invoice.unpaid.should_not include(@paid)
  end
  
  it "should default date and paid to false" do
  	@invoice = Invoice.new
  	@invoice.date.should eql Time.today
  	@invoice.should_not be_paid
  end
  
  it "should create an adjustment item when a total is assigned that doesnt equal the sum of the line items" do
  	@invoice = Factory :invoice
  	count = @invoice.adjustments.length
  	@invoice.total += 50
  	@invoice.adjustments.length.should eql count+1
  	@invoice.adjustments.last.total.should eql 50
  end
  
  it "should handle the total attribute through mass assignment" do
    @invoice = Factory :invoice
    5.times { @invoice.works.create! Factory(:work).attributes }
    total = @invoice.total
    @invoice.attributes = { :total => total-50 }
    @invoice.save
    @invoice.reload.total.should == total-50
  end

  it "should not create an adjustment item when a total is assigned that equals the sum of the line items" do
  	@invoice = Factory :invoice
  	count = @invoice.adjustments.length
  	@invoice.total = @invoice.total
  	@invoice.adjustments.length.should eql count
  end
  
end
