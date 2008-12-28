class Work < LineItem
  include Comparable
	validates_presence_of :user, :start, :finish
	
	def self.merge_from_ids(ids)
	  works = Work.find ids, :order => "finish DESC"

	  returning work = works.first do
      work.update_attributes(
        :hours => works.sum(&:hours),
        :notes => works.collect(&:notes_with_period) * ' '
      )
      works.each { |w| w.destroy unless w == work }
    end
	end
	
	def total
		(rate * hours).round(2)
	end
	
	def total=(value)
	  self.hours = value/rate
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
