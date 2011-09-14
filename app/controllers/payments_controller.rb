class PaymentsController < ApplicationController
  def create 
    params[:payment][:amount] = params[:amount_total]   if params[:payment][:payment_method_id] == "2"
    if params[:payment][:amount] == "" or params[:payment][:amount] == "0"
      @error = "Amount cannot be blank or zero"
    else
      @payment = Payment.create(params[:payment])
      @ticket = Ticket.find(params[:payment][:owner_id])
      @total_payments = @ticket.payments.sum(:amount)
    end
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

