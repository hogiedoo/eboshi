# == Schema Information
# Schema version: 20081222015211
#
# Table name: users
#
#  id                :integer(4)      not null, primary key
#  login             :string(255)
#  email             :string(255)
#  crypted_password  :string(255)
#  password_salt     :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  rate              :decimal(10, 2)
#  color             :string(255)
#  persistence_token :string(255)
#  login_count       :integer(4)
#  last_request_at   :datetime
#  last_login_at     :datetime
#  current_login_at  :datetime
#  last_login_ip     :string(255)
#  current_login_ip  :string(255)
#  last_client_id    :integer(4)
#

class User < ActiveRecord::Base
  acts_as_authentic
  
  belongs_to :last_client, :class_name => "Client"
  has_many :assignments, :dependent => :destroy
  has_many :clients, :through => :assignments
  
  def name
    login
  end
  
  def authorized?(object)
    return if object.is_a? Client and clients.include?(object)
    return if object.is_a? Assignment and object.client.users.include?(self)
    raise ActiveRecord::RecordNotFound
  end
end
