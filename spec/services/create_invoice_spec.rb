require 'rails_helper'

RSpec.describe Invoices::CreateInvoice do
  let(:redirect_url) { "https://example.com/redirect" }
  let(:webhook_url)  { "https://example.com/webhook" }
  let(:amount)       { 100.0 }
  let(:metadata)     { { order_id: 123 } }
  let(:invoice_id)   { "inv-98765" }
  let(:page_url)     { "https://pay.example.com/invoice-page" }

  let(:adapter_double) do
    instance_double(
      MonopayAdapter,
      create: create_result,
      invoice_id: invoice_id,
      page_url: page_url
    )
  end

  let(:provider_class) { class_double(MonopayAdapter, new: adapter_double) }

  describe "#call" do
    context "when invoice creation is successful" do
      let(:create_result) { true }

      it "returns success with invoice_id and page_url" do
        service = described_class.new(provider_class: provider_class)
        result = service.call(
          amount: amount,
          redirect_url: redirect_url,
          webhook_url: webhook_url,
          metadata: metadata
        )

        expect(provider_class).to have_received(:new).with(
          redirect_url: redirect_url,
          webhook_url: webhook_url
        )
        expect(adapter_double).to have_received(:create).with(amount, additional_params: metadata)

        expect(result.success).to be true
        expect(result.invoice_id).to eq(invoice_id)
        expect(result.page_url).to eq(page_url)
        expect(result.error).to be_nil
      end
    end

    context "when invoice creation fails" do
      let(:create_result) { false }

      it "returns failure with error message" do
        service = described_class.new(provider_class: provider_class)
        result = service.call(
          amount: amount,
          redirect_url: redirect_url,
          webhook_url: webhook_url,
          metadata: metadata
        )

        expect(provider_class).to have_received(:new).with(
          redirect_url: redirect_url,
          webhook_url: webhook_url
        )
        expect(adapter_double).to have_received(:create).with(amount, additional_params: metadata)

        expect(result.success).to be false
        expect(result.invoice_id).to be_nil
        expect(result.page_url).to be_nil
        expect(result.error).to eq("Failed to create invoice")
      end
    end
  end
end
