require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Work do
  describe "when merging a list of ids" do
    it "should gracefully handle a single id" do
      @work = Factory :work
      @merged = Work.merge_from_ids [@work.id]
      @merged.reload
      @merged.should == @work
    end
    
    it "should correctly merge multiple items" do
      @client = Factory :client
      @billed1 = Factory :work, :client => @client, :start => Time.today + 1.hour, :finish => Time.today + 2.hour
      @billed2 = Factory :work, :client => @client
      @merged = Work.merge_from_ids [@billed1.id, @billed2.id]
      @merged.reload
      @merged.invoice.should == @billed1.invoice
      @merged.hours.should == 2
      @merged.total.should == 100
      @merged.notes.should include(@billed1.notes)
      @merged.notes.should include(@billed2.notes)
      lambda { Work.find(@billed1.id) }.should_not raise_error(ActiveRecord::RecordNotFound)
      lambda { Work.find(@billed2.id) }.should raise_error(ActiveRecord::RecordNotFound)
    end
  end
  
	describe "billed" do
		before(:each) do
			@line_item = Factory :work, :start => Time.today, :finish => Time.today + 1.hour, :rate => 50
		end

		it "should calculate the hours correctly" do
			@line_item.hours.should == 1
		end

		it "should calculate the total correctly" do
			@line_item.total.should == 50
		end

		it "should be compared to other line items by start time descending" do
      @billed1 = Factory :work, :start => Time.today + 1.hour, :finish => Time.today + 2.hour
      @billed2 = Factory :work
			@billed1.should < @billed2
			@billed1.should_not > @billed2
			(@billed1 <=> @billed2).should eql -1
		end
	
		it "should be less than adjustment items" do
		  @adjustment = Factory :adjustment
			@line_item.should < @adjustment
			@line_item.should_not > @adjustment
			(@line_item <=> @adjustment).should eql -1
		end

		it "should not be checked" do
			@line_item.should_not be_checked
		end

		it "should report as complete" do
			@line_item.should_not be_incomplete
		end
		
		it "should be able to set hours manually" do
		  @line_item.hours = 4
		  @line_item.finish.should eql @line_item.start + 4.hours
		end
	end
	
	describe "unbilled" do
		it "should be checked" do
			@line_item = Factory :work, :invoice => nil
			@line_item.should be_checked
		end
	end
	
	describe "incomplete" do
		before do
			@line_item = Factory :work, :invoice => nil
			@line_item.finish = @line_item.start
		end

		it "should report as incomplete" do
			@line_item.should be_incomplete
		end
					
		it "should clock out correctly" do
			@line_item.clock_out
			@line_item.should_not be_incomplete
		end
	end

end
