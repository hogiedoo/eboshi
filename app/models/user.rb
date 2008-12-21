class User < ActiveRecord::Base
  acts_as_authentic
  
  def name
    login
  end
end
