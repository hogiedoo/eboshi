module ActiveRecord
  class Base  
    def self.to_select(conditions = nil)
      find(:all).collect { |x| [x.name,x.id] }
    end
    
    def id_or_new
      id ? id.to_s : 'new'
    end
  end
end

class Array
  def to_select
    self.collect { |x| [x.name,x.id] }
  end
end

class Time 
  DATE_FORMATS[:pretty_time] = '%I:%M&nbsp;%p'
  DATE_FORMATS[:slash] = '%m/%d/%y'
end

class Array
  def / pieces
    return [] if pieces.zero?
    piece_size = (length.to_f / pieces).ceil
    [first(piece_size), *last(length - piece_size) / (pieces - 1)]
  end
end

class String
  def url_encode
    CGI::escape(self)
  end
  
  def url_decode
    CGI::unescape(self)
  end
  
  def word_wrap(line_width = 80)
    self.split("\n").collect do |line|
      line.length > line_width ? line.gsub(/(.{1,#{line_width}})(\s+|$)/, "\\1\n").strip : line
    end * "\n"
  end
end

class NilClass
  def each; self; end
  include Enumerable
end

class Date
  def beginning_of_week
    result = self - self.wday
    self.acts_like?(:time) ? result.midnight : result
  end
  
  def end_of_week
    days_to_saturday = 6-self.wday
    result = self + days_to_saturday.days
    self.acts_like?(:time) ? result.midnight : result
  end
  
  def saturday?
    wday == 6
  end
  
  def sunday?
    wday == 0
  end
  
  def today?
    self.to_date == Time.zone.today.to_date
  end
end

def Time.today
  t = Time.now
  t - ((t.to_f + t.gmt_offset) % 86400)
end unless defined? Time.today
