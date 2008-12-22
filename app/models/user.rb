class User < ActiveRecord::Base
  acts_as_authentic
  
  belongs_to :last_client, :class_name => "Client"
  
  def name
    login
  end
end
