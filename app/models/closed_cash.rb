class ClosedCash < ActiveRecord::Base

  def mytickets
    t = Ticket.arel_table
    Ticket.valid.where(t[:created_at].gt(created_at)).where(t[:updated_at].lt(updated_at)).map{ |t| t.id }
  end

  def cash
    Payment.joins(:payment_method).where("payment_methods.name like 'Cash'").where("payments.owner_id in (?)", mytickets).select('sum(amount)')[0].send('sum(amount)')
  end

  def card
    Payment.joins(:payment_method).where("payment_methods.name like 'Credit Card'").where("payments.owner_id in (?)", mytickets).select('sum(amount)')[0].send('sum(amount)')

  end

  def debt
    Payment.joins(:payment_method).where("payment_methods.name like 'Debt'").where("payments.owner_id in (?)", mytickets).select('sum(amount)')[0].send('sum(amount)')

  end

  def free
    Payment.joins(:payment_method).where("payment_methods.name like 'Debt'").where("payments.owner_id in (?)", mytickets).select('sum(amount)')[0].send('sum(amount)')
  end

  def total
    (cash || 0)   +  (card || 0 )  + ( debt || 0 ) + (free || 0)
  end

end
