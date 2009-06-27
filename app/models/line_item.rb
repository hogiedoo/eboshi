# == Schema Information
# Schema version: 20081222015211
#
# Table name: line_items
#
#  id         :integer(4)      not null, primary key
#  client_id  :integer(4)
#  user_id    :integer(4)
#  start      :datetime
#  finish     :datetime
#  rate       :decimal(10, 2)
#  notes      :text
#  created_at :datetime
#  updated_at :datetime
#  invoice_id :integer(4)
#  type       :string(255)
#

class LineItem < ActiveRecord::Base
  include Comparable

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
      self.user = User.find_by_name!(name)
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

  def <=> target
    (target.start || Time.zone.parse("0000-01-01")) <=> (self.start || Time.zone.parse("0000-01-01"))
  end
end
