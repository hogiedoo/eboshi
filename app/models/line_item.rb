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
    
  scope :unbilled, :conditions => "invoice_id IS NULL", :order => 'start DESC'
  scope :on_date,  lambda { |date| { :conditions => "`start` BETWEEN '#{date.beginning_of_day.utc.to_s(:db)}' AND '#{date.end_of_day.utc.to_s(:db)}'" } }
  scope :on_week,  lambda { |date| { :conditions => "`start` BETWEEN '#{date.beginning_of_week.yesterday.beginning_of_day.utc.to_s(:db)}' AND '#{date.end_of_week.yesterday.end_of_day.utc.to_s(:db)}'" } }
  scope :on_month, lambda { |date| { :conditions => "`start` BETWEEN '#{date.beginning_of_month.beginning_of_day.utc.to_s(:db)}' AND '#{date.end_of_month.end_of_day.utc.to_s(:db)}'" } }
  scope :on_year,  lambda { |date| { :conditions => "`start` BETWEEN '#{date.beginning_of_year.beginning_of_day.utc.to_s(:db)}' AND '#{date.end_of_year.end_of_day.utc.to_s(:db)}'" } }

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
  
  def unbilled?
    invoice_id.nil?
  end

  def checked?
    unbilled?
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
    if notes.nil? or notes.last.match(/[.?]/)
      notes
    else
      "#{notes}."
    end
  end

  def <=> target
    (target.start || Time.zone.parse("0000-01-01")) <=> (self.start || Time.zone.parse("0000-01-01"))
  end
end
