class Ticket < ActiveRecord::Base
  belongs_to :r_table
  belongs_to :guest
  has_many :ticket_lines, :dependent => :destroy
  has_many :payments, :as => :owner

  scope :valid, where("status like 'closed'")

  def subtotal
    sum = 0
    ticket_lines.each do |t|
      sum += t.sell_price * t.qty 
    end
    return sum
  end

  def discount
    return 0
  end

  def tax
    return 0
  end

  def total
    subtotal - discount + tax 
  end

end
