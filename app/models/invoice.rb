# == Schema Information
# Schema version: 20081222015211
#
# Table name: invoices
#
#  id           :integer(4)      not null, primary key
#  client_id    :integer(4)
#  date         :datetime
#  project_name :string(255)
#

class Invoice < ActiveRecord::Base
  belongs_to :client
  has_many :line_items
  has_many :works
  has_many :adjustments
  has_many :payments, :dependent => :destroy, :order => 'created_at DESC'
  
  validates_presence_of :client, :date

  def self.unpaid
    self.all(:order => "`date` DESC").reject(&:paid?)
  end
  
  def self.paid
    self.all(:order => "`date` DESC").select(&:paid?)
  end
  
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
    line_items << adjustments.build(:total => difference, :client_id => client.id)
  end
  
  def balance
    total - payments.to_a.sum(&:total)
  end

  def status
    return 'unbilled' if new_record?
    return paid? ? 'paid' : 'unpaid'
  end
  
  def paid?
    !line_items.empty? && !payments.empty? && balance == 0
  end
  
  def total_hours
    line_items.to_a.sum(&:hours)
  end
  
  def consistant_rate
    return true if works.empty?
    rates = works.collect(&:rate).uniq
    rates.length == 1 ? rates.first : false
  end
  
end
