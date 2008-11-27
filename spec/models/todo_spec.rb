require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Todo do
  it "should assign user by name" do
    @user = Factory :user
    @todo = Factory :todo
    @todo.user_name = @user.name
    @todo.user.should eql @user
  end
end
