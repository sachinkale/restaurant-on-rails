class TicketsController < ApplicationController
  def create
    t = Ticket.arel_table
    @ticket_present = Ticket.where(t[:r_table_id].eq(params[:ticket][:r_table_id])).where(t[:status].eq(nil))[0]
    @ticket = Ticket.create(params[:ticket]) if @ticket_present.nil?
    respond_to do |format|
      format.js { logger.info('in js') }
      format.html{ logger.info('in html')}
    end
  end

  def update
    @ticket = Ticket.find(params[:id])
    respond_to do |format|
      format.js do 
        if @ticket.update_attributes(params[:ticket])
          @error = false
        else
          @error = true
        end
      end
    end

  end

  def add_discount
    @ticket = Ticket.find(params[:add_discount][:ticket_id])
    @discount = Discount.where("dcode like ?",params[:discount_code])[0]


    respond_to do |format|
      format.js do 
        if not @discount.nil? and @discount.status.nil? and not @discount.created_at < 5.minutes.ago
          @discount.ticket = @ticket
          @discount.status = "used"
          @error = false if not @discount.save
        else
          @error = true
        end
      end
    end
  end

  def add_guest
    @ticket = Ticket.find(params[:add_guest][:ticket_id])
    respond_to do |format|
      format.js do 
        if @ticket.update_attribute(:guest_id, params[:add_guest][:guest_id])
          @error = false
        else
          @error = true
        end
      end
    end
  end

  
  def change_table
    @ticket = Ticket.find(params[:change_table][:ticket_id])
    respond_to do |format|
      format.js do
        if @ticket.update_attribute(:r_table_id, params[:change_table][:table_id])
          @error = false
        else
          @error = true
        end
      end
    end

  end

  def destroy
  end

end
