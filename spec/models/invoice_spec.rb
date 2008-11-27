require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Invoice do
  it "should create a new instance given valid attributes" do
    Invoice.create! Factory.attributes_for(:invoice)
  end
  
  it "should default date and paid to nil" do
  	@invoice = Invoice.new
  	@invoice.date.should eql Time.today
  	@invoice.paid.should be_nil
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
    total = @invoice.total
    @invoice.attributes = { :total => total-50 }
    @invoice.save
    @invoice.reload.total.should eql total-50
  end

  it "should not create an adjustment item when a total is assigned that equals the sum of the line items" do
  	@invoice = Factory :invoice
  	count = @invoice.adjustments.length
  	@invoice.total = @invoice.total
  	@invoice.adjustments.length.should eql count
  end
  
  it "should handle the paid boolean through mass assignment" do
    @invoice = Invoice.new "paid(1i)" => "2008", "paid(2i)" => "10", "paid(3i)" => "1", "paid" => "0"
    @invoice.paid.should be_nil

    @invoice = Invoice.new 
    @invoice.attributes = { "paid(1i)" => "2008", "paid(2i)" => "10", "paid(3i)" => "1", "paid" => "1" }
    @invoice.paid.to_s(:slash).should == "10/01/08"
    
    @invoice = Factory :invoice
    @invoice = Invoice.new "paid(1i)" => "2008", "paid(2i)" => "10", "paid(3i)" => "1", "paid" => "0"
    @invoice.paid.should be_nil
  end
end
