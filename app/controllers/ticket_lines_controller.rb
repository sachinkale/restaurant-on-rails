class TicketLinesController < ApplicationController
  def create
    @ticket_line =  TicketLine.create(params[:ticket_line])
    respond_to do |format|
      format.js
    end
  end
end
