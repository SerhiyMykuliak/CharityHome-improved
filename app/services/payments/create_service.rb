module Payments
  class CreateService
    Result = Struct.new(:success?, :redirect_url, :error)

    def initialize(invoice_service_class: Invoices::CreateInvoice)
      @invoice_service_class = invoice_service_class
    end 

    def call(payment:, cause:, redirect_url:, webhook_url:)
      return Result.new(false, nil, "Invalid payment") unless payment.valid?

      invoice_service = @invoice_service_class.new
      invoice_result = invoice_service.call(
        amount: payment.amount,
        redirect_url: redirect_url,
        webhook_url: webhook_url,
        metadata: { destination: cause.title }
      )

      unless invoice_result.success?
        return Result.new(false, nil, invoice_result.error)
      end 

      payment.reference = invoice_result.invoice_id

      if payment.save
        Result.new(true, invoice_result.page_url, nil)
      else
        Result.new(false, nil, "Failed to save payment: #{payment.errors.full_messages.join(", ")}")
      end
    end 
  end 
end 