class PaymentsController < ApplicationController
  def create 
    params[:payment][:amount] = params[:given_amount]   if params[:payment][:payment_method_id] == "2"
    @payment = Payment.create(params[:payment])
    @ticket = Ticket.find(params[:payment][:owner_id])
    @total_payments = @ticket.payments.sum(:amount)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @payment = Payment.find(params[:id])
    @ticket = Ticket.find(@payment.owner_id)
    @error = true
    if @payment.destroy
      @error = false
      @total_payments = @ticket.payments.sum(:amount)
    end
    respond_to do |format|
      format.js
    end
  end

end

