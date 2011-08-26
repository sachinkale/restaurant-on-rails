class HomeController < ApplicationController
  def index
    @ticket = Ticket.new
    @ticket_line = TicketLine.new
    @rtables = RTable.all
    @floor = Floor.first
    @categories = Category.includes(:products).all
  end

end
