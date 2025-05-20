module Invoices
  class CreateInvoice
    attr_reader :success, :invoice_id, :page_url, :error
  
    def initialize(provider_class: MonopayAdapter)
      @provider_class = provider_class
    end 

    def call(amount:, redirect_url:, webhook_url:, metadata: {})
      provider = @provider_class.new(
        redirect_url: redirect_url,
        webhook_url: webhook_url
      )

      if provider.create(amount, additional_params: metadata)
        @success = true
        @invoice_id = provider.invoice_id
        @page_url = provider.page_url
      else
        @success = false
        @error = "Failed to create invoice"
      end

      self
    end 
  end 
end 
