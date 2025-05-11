class PaymentsController < ApplicationController

  def new
    @cause = Cause.find(params[:cause_id])
    @payment = Payment.new

  end 

  def create
    @cause = Cause.find(params[:cause_id])
    @payment = @cause.payments.build(payment_params)

    if @payment.valid?
      invoice = MonopayRuby::Invoices::AdvancedInvoice.new(
        redirect_url: cause_url(@cause),
        webhook_url: webhooks_monopay_url
      )
  
      if invoice.create(@payment.amount, additional_params: {destination: @cause.title})
        @payment.reference = invoice.invoice_id
  
        if @payment.save
          redirect_to invoice.page_url, allow_other_host: true
        else 
          Rails.logger.error("Failed to save payment: #{@payment.errors.full_messages}")
          flash[:error] = "Payment could not be saved. Please try again."
          redirect_to new_cause_payment_path(@cause)
        end 
  
      else
        Rails.logger.error("Failed to create invoice for payment: #{@payment.inspect}")
        flash[:error] = "Invoice could not be saved. Please try again."
        redirect_to new_cause_payment_path(@cause)
      end
    else
      flash[:error] = "Required fields must be filled in."
      redirect_to new_cause_payment_path(@cause)
    end 
  end

  private

  def payment_params
    params.require(:payment).permit(:amount, :username, :email, :description)
  end 
end
