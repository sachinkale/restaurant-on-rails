class HomeController < ApplicationController
  before_filter :authenticate_user!

  def start


  end

  def index
    @ticket = Ticket.new
    @ticket_line = TicketLine.new
    #@rtables = RTable.all
    @floors = Floor.includes(:r_tables).all
    @categories = Category.includes(:products).all
    @products = Product.all(:select => ['code','name']).map { |p| p.code + ' ' + p.name }
    @payment_methods = PaymentMethod.all
    @payment = Payment.new
    @guests = Guest.all(:select => ['id','FirstName','LastName']).map { |g| g.id.to_s + ' ' + g.FirstName + ' ' + g.LastName }
  end

  def close_cash
    @closed = Ticket.where(:status => nil).empty?
    t = Ticket.arel_table
    @closed_cash = ClosedCash.last
    if @closed_cash.nil?
      tickets = Ticket.valid.map{ |t| t.id }
      @closed_cash = ClosedCash.create
    else
      tickets = Ticket.valid.where(t[:created_at].gt(@closed_cash.created_at)).map{ |t| t.id }
    end
    @total_sale  = 0
    @total_free =  Payment.joins(:payment_method).where("payment_methods.name like 'Free'").where("payments.owner_id in (?)", tickets).select('sum(amount)')[0].send('sum(amount)')
    @total_debt =  Payment.joins(:payment_method).where("payment_methods.name like 'Debt'").where("payments.owner_id in (?)", tickets).select('sum(amount)')[0].send('sum(amount)')
    @total_card =  Payment.joins(:payment_method).where("payment_methods.name like 'Credit Card'").where("payments.owner_id in (?)", tickets).select('sum(amount)')[0].send('sum(amount)')

    @total_cash = Payment.joins(:payment_method).where("payment_methods.name like 'Cash'").where("payments.owner_id in (?)", tickets).select('sum(amount)')[0].send('sum(amount)')

    
  end

  def create_close_cash
     @closed_cash = ClosedCash.find(params[:id])
     @closed_cash.touch
     if not ClosedCash.create
       flash[:notice] = "Error while closing cash!"
     end

     redirect_to close_cash_url
  end
end
