class PaymentsController < ApplicationController

  def new
    @cause = Cause.find(params[:cause_id])
    @payment = Payment.new

  end 

  def create
    @cause = Cause.find(params[:cause_id])
    @payment = @cause.payments.build(payment_params)

    service = Payments::CreatePaymentService.new
    result = service.call(
      payment: @payment,
      cause: @cause,
      redirect_url: cause_url(@cause),
      webhook_url: webhooks_monopay_url
    )

    if result.success
      redirect_to result.redirect_url, allow_other_host: true
    else
      Rails.logger.error(result.error)
      flash[:error] = result.error
      redirect_to new_cause_payment_path(@cause)
    end

  end

  private

  def payment_params
    params.require(:payment).permit(:amount, :username, :email, :description)
  end 
end
