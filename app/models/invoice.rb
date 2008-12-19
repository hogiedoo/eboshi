class Invoice < ActiveRecord::Base
	belongs_to :client
	has_many :line_items, :dependent => :destroy
	has_many :works
	has_many :adjustments
	has_many :payments, :order => 'created_at DESC'
	
	def self.unpaid
	  self.all(:order => "`date` DESC").reject(&:paid?)
	end
	
	def self.paid
	  self.all(:order => "`date` DESC").select(&:paid?)
	end
	
	validates_presence_of :client, :date, :project_name

	def initialize(options = {})
		options = {} if options.nil?
		options.reverse_merge!(:date => Date.today)
		super
	end

	def total
		line_items.to_a.sum(&:total)
	end
	
	def total=(value)
		difference = value.to_f - total
		return total if difference.abs < 0.01
		line_items << adjustments.build(:total => difference)
	end
	
	def balance
	  total - payments.sum(:total)
	end

  def status
    return 'unbilled' if new_record?
    return paid? ? 'paid' : 'unpaid'
  end
  
  def paid?
    !line_items.empty? && !payments.empty? && balance == 0
  end
  
end
