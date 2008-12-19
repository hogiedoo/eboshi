class Work < LineItem
  include Comparable
	validates_presence_of :client_id, :user_id, :rate, :start, :finish
	
	def self.merge_from_ids(ids)
	  works = Work.find ids, :order => "finish DESC"
	  works.each do |w|
	    w.notes += '.' unless w.notes.nil? or w.notes.last.match /[.?]/
	  end
	  returning work = works.first do
	    unless works.empty?
	      work.hours = works.sum(&:hours)
	      work.notes = works.collect(&:notes) * ' '
	      works.shift
	      works.each(&:destroy)
	      work.save!
	    end
    end
	end
	
	def total
		(hours * rate).round(2)
	end
	
	def hours=(total)
	  update_attribute :finish, start + total.hours
	end
	
	def clock_out
		update_attributes :finish => Time.now
	end
	
	def <=> target
		result = (target <=> self.start)
		target.is_a?(Work) ? result : result*-1
	end

	def incomplete?
		start >= finish
	end

end
