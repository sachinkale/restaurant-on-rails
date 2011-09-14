class HomeController < ApplicationController
  before_filter :authenticate_user!

  def start


  end

  def index
    @ticket = Ticket.new
    @ticket_line = TicketLine.new
    @rtables = RTable.all
    @floor = Floor.first
    @categories = Category.includes(:products).all
    @products = Product.all(:select => ['code','name']).map { |p| p.code + ' ' + p.name }
    @payment_methods = PaymentMethod.all
    @payment = Payment.new
  end

  def close_cash
    #unless Ticket.where(:status => nil).empty?
    #  flash[:notice] = "Ticket is open, please close the ticket first!"
    #  redirect_to "/"
    #  return
    #end
    @closed = Ticket.where(:status => nil).empty?
    @close_cash = ClosedCash.new
    t = Ticket.arel_table
    @recent = ClosedCash.last
    if @recent.nil?
      tickets = Ticket.valid.map{ |t| t.id }
    else
      tickets = Ticket.valid.where(t[:created_at].gt(@recent.created_at)).map{ |t| t.id }
    end
    @total_sale  = 0
    @total_free =  Payment.joins(:payment_method).where("payment_methods.name like 'Free'").where("payments.owner_id in (?)", tickets).select('sum(amount)')[0].send('sum(amount)')
    @total_debt =  Payment.joins(:payment_method).where("payment_methods.name like 'Debt'").where("payments.owner_id in (?)", tickets).select('sum(amount)')[0].send('sum(amount)')
    @total_card =  Payment.joins(:payment_method).where("payment_methods.name like 'Credit Card'").where("payments.owner_id in (?)", tickets).select('sum(amount)')[0].send('sum(amount)')

    @total_cash = Payment.joins(:payment_method).where("payment_methods.name like 'Cash'").where("payments.owner_id in (?)", tickets).select('sum(amount)')[0].send('sum(amount)')

    
  end

  def create_close_cash
     
     if not ClosedCash.create
       flash[:notice] = "Error while closing cash!"
     end

     redirect_to close_cash_url
  end
end
