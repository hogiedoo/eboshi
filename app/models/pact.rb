# == Schema Information
# Schema version: 20090324074829
#
# Table name: pacts
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  client_id  :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Pact < ActiveRecord::Base
  belongs_to :user
  belongs_to :client
end
