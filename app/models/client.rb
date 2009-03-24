# == Schema Information
# Schema version: 20081222015211
#
# Table name: clients
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  address    :string(255)
#  city       :string(255)
#  state      :string(255)
#  zip        :string(255)
#  country    :string(255)
#  email      :string(255)
#  contact    :string(255)
#  phone      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Client < ActiveRecord::Base
	has_many :line_items, :dependent => :destroy
	has_many :works
	has_many :adjustments
	has_many :invoices, :dependent => :destroy
	has_many :payments, :through => :invoices
	
	validates_presence_of :name

	def build_invoice_from_unbilled(line_items_ids = nil)
	  lis = line_items_ids ? LineItem.find(line_items_ids) : line_items.unbilled
  	invoices.build :project_name => default_project_name, :line_items => lis
	end

	def invoices_with_unbilled
    [build_invoice_from_unbilled] + invoices.all(:order => 'date DESC')
	end
	
	def balance
		credits - debits
	end
	
	def unbilled_balance
  	return 0.0 if line_items.empty?
	  line_items.unbilled.to_a.sum(&:total)
	end
	
	def overdue_balance
	  balance - unbilled_balance
	end
	
	def credits
		line_items.to_a.sum(&:total)
	end
	
	def debits
		payments.to_a.sum(&:total)
	end
	
	def clock_in(user)
	  returning line_item = Work.new do
	    now = Time.now
	    line_item.attributes = { :start => now, :finish => now, :user => user, :rate => default_rate(user) }
    	self.line_items << line_item
  	end
	end
	
	def default_rate(user)
	  # look for last rate for this client / agent combo. fallback to default user rate.
		line_items.find(:first, :conditions => ["type='Work' AND start <> finish AND user_id=? AND rate IS NOT NULL", user.id], :order => "start DESC").try(:rate) || user.rate
	end

	def default_project_name
	  # look for last project name for this client
		invoices.find(:last).try(:project_name)
	end
end
