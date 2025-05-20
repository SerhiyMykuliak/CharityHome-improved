module Payments
  class CreatePaymentService
    attr_reader :success, :redirect_url, :error

    def initialize(invoice_service_class: Invoices::CreateInvoice)
      @invoice_service_class = invoice_service_class
    end 

    def call(payment:, cause:, redirect_url:, webhook_url:)

      return failure("Failed to save payment: #{payment.errors.full_messages.first}") unless payment.valid?

      invoice_service = @invoice_service_class.new
      invoice_result = invoice_service.call(
        amount: payment.amount,
        redirect_url: redirect_url,
        webhook_url: webhook_url,
        metadata: { destination: cause.title }
      )

      return failure(invoice_result.error) unless invoice_result.success

      payment.reference = invoice_result.invoice_id

      if payment.save
        @success = true
        @redirect_url = invoice_result.page_url
        self
      else
        failure("Failed to save payment: #{payment.errors.full_messages.first}")
      end
    end
    
    private

    def failure(message)
      @success = false
      @error = message
      self
    end 

  end 
end 
