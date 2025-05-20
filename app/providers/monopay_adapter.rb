class MonopayAdapter
  attr_reader :invoice_id, :page_url

  def initialize(redirect_url:, webhook_url:)
    @redirect_url = redirect_url
    @webhook_url = webhook_url
  end

  def create(amount, additional_params: {})
    invoice = MonopayRuby::Invoices::AdvancedInvoice.new(
      redirect_url: @redirect_url,
      webhook_url: @webhook_url
    )

    if invoice.create(amount, additional_params: additional_params)
      @invoice_id = invoice.invoice_id
      @page_url = invoice.page_url
      true
    else
      false
    end 
  end 
end 