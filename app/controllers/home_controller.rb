class HomeController < ApplicationController
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


end
