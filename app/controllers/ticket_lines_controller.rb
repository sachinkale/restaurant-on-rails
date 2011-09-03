class TicketLinesController < ApplicationController
  def create
    @product= Product.where(:code => "#{params[:code]}")[0]
    params[:ticket_line][:sell_price] = @product.sell_price
    params[:ticket_line][:product_id] = @product.id
    @ticket_line =  TicketLine.create(params[:ticket_line])
    
    respond_to do |format|
      format.js
    end
  end

  def update
    #@ticket_line = TicketLine.find(params[:id])
    @ticket_lines = TicketLine.find(params[:ticket_line_ids].split(/,/))
    @ticket = @ticket_lines[0].ticket
    @deleted_items = Array.new
    if params[:action_for_ticket] == "add"
      @ticket_lines.each do |t|
        t.update_attribute(:qty, t.qty + 1)
      end
    elsif params[:action_for_ticket] == "sub"
      @ticket_lines.each do |t|
        if t.qty == 1
          @deleted_items.push t.id
          t.destroy
        else
          t.update_attribute(:qty, t.qty - 1)
        end
      end
    elsif params[:action_for_ticket] == "del"
      @ticket_lines.each do |t|
        @deleted_items.push t.id
        t.destroy
      end
    end
    #@ticket_line.update_attribute(:qty, @ticket_line.qty + 1 )
    respond_to do |format|
      format.js {}
    end
  end



end
