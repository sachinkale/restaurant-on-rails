class Ticket < ActiveRecord::Base
  belongs_to :r_table
  belongs_to :guest
  has_many :ticket_lines, :dependent => :destroy
  has_many :payments, :as => :owner
  has_one :discount

  scope :valid, where("status like 'closed'")

  def subtotal
    sum = 0
    ticket_lines.each do |t|
      sum += t.sell_price * t.qty 
    end
    return sum
  end

  def get_discount
    if discount.nil?
      return 0
    else
      return (subtotal * APP_CONFIG['discount']/100).round
    end
  end

  def tax
    return 0
  end

  def total
    subtotal - get_discount + tax 
  end




end
