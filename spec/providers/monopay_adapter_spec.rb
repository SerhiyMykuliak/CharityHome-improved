require 'rails_helper'

RSpec.describe MonopayAdapter do
  let(:redirect_url) { "https://example.com/redirect" }
  let(:webhook_url)  { "https://example.com/webhook" }
  let(:amount)       { 100.0 }
  let(:invoice_id)   { "inv-123456" }
  let(:page_url)     { "https://pay.monobank.ua/invoice-page" }
  let(:adapter)      { described_class.new(redirect_url: redirect_url, webhook_url: webhook_url) }

  describe "#create" do
    context "when invoice is successfully created" do
      let(:invoice_double) do
        instance_double(MonopayRuby::Invoices::AdvancedInvoice, create: true, invoice_id: invoice_id, page_url: page_url)
      end

      before do
        allow(MonopayRuby::Invoices::AdvancedInvoice).to receive(:new).with(redirect_url: redirect_url, webhook_url: webhook_url).and_return(invoice_double)
      end

      it "returns true and sets invoice_id and page_url" do
        result = adapter.create(amount)

        expect(result).to be true
        expect(adapter.invoice_id).to eq(invoice_id)
        expect(adapter.page_url).to eq(page_url)
      end
    end

    context "when invoice creation fails" do
      let(:invoice_double) do
        instance_double(MonopayRuby::Invoices::AdvancedInvoice, create: false)
      end

      before do
        allow(MonopayRuby::Invoices::AdvancedInvoice).to receive(:new).and_return(invoice_double)
      end

      it "returns false and does not set invoice_id or page_url" do
        result = adapter.create(amount)

        expect(result).to be false
        expect(adapter.invoice_id).to be_nil
        expect(adapter.page_url).to be_nil
      end
    end
  end
end
