class LineItem < ActiveRecord::Base
	belongs_to :client
	belongs_to :user
	belongs_to :invoice

  validates_presence_of :client, :rate
  	
	named_scope :unbilled, :conditions => "invoice_id IS NULL", :order => 'start DESC'

	def total
		0
	end

	def hours
		return 0 unless finish and start
		BigDecimal.new(((finish - start) / 60 / 60).to_s)
	end
	
	def == (target)
		target == id
	end
	
	def checked?
		invoice_id.nil?
	end
	
	def user_name=(name)
		unless name.nil?
			self.user = User.find_by_login!(name)
		end
	end
	
	def invoice_total
	  invoice.try(:total) || client.unbilled_balance
	end
	
	def notes_with_period
	  returning notes do
	    notes += '.' unless notes.nil? or notes.last.match(/[.?]/)
	  end    
	end
end
