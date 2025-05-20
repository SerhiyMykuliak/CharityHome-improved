module Invoices
  class CreateInvoice
    Result = Struct.new(:success?, :invoice_id, :page_url, :error)
  
    def initialize(provider_class: MonopayAdapter)
      @provider_class = provider_class
    end 

    def call(amount:, redirect_url:, webhook_url:, metadata: {})
      provider = @provider_class.new(
        redirect_url: redirect_url,
        webhook_url: webhook_url
      )

      if provider.create(amount, additional_params: metadata)
        Result.new(true, provider.invoice_id, provider.page_url, nil)
      else
        Result.new(false, nil, nil, "Failed to create invoice")
      end
    end 
  end 
end 