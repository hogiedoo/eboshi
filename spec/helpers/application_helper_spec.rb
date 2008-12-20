require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApplicationHelper do
  describe "number_to_per_hour" do
    it "should return a formatted string" do
      helper.number_to_per_hour(10).should == "$10/hr"
    end
    it "should include cents if present" do
      helper.number_to_per_hour(10.50).should == "$10.50/hr"
    end
  end
end
