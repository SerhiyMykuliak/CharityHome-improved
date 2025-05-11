class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def monopay
    webhook_validator = MonopayRuby::Webhooks::Validator.new(request)

    if webhook_validator.valid?
      data = JSON.parse(request.raw_post)
      payment = Payment.includes(:cause).find_by(reference: data["invoiceId"])
      
      if payment
        ActiveRecord::Base.transaction do
          payment.update!(status: data["status"])
          payment.cause.update_collected_amount(payment)
        end 
        head :ok
      else
        Rails.logger.error("Payment not found for invoiceId: #{data["invoiceId"]}")
        head :not_found
      end 
    else
      Rails.logger.warn("Invalid Monopay webhook received")
      return head :unauthorized
    end
  end
end
