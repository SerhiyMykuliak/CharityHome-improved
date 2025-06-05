require 'rails_helper'

RSpec.describe Payments::CreatePaymentService do
  let(:cause)         { create(:cause) }
  let(:payment)       { build(:payment, amount: 100.0) }

  let(:redirect_url)  { 'https://example.com/redirect' }
  let(:webhook_url)   { 'https://example.com/webhook' }

  let(:invoice_result) do
    instance_double(
      'Invoices::CreateInvoice',
      success: invoice_success,
      invoice_id: invoice_id,
      page_url: page_url,
      error: invoice_error
    )
  end

  let(:invoice_service)       { instance_double('Invoices::CreateInvoice', call: invoice_result) }
  let(:invoice_service_class) { class_double('Invoices::CreateInvoice', new: invoice_service) }

  let(:invoice_id)            { 'inv-123' }
  let(:page_url)              { 'https://pay.example.com/invoice' }
  let(:invoice_error)         { nil }
  let(:invoice_success)       { true }

  describe '#call' do

    context 'when all is successful' do
      before do
        allow(payment).to receive(:valid?).and_return(true)
        allow(payment).to receive(:save).and_return(true)
        allow(payment).to receive(:reference=).with(invoice_id)
      end

      it 'returns success and sets redirect_url' do
        service = described_class.new(invoice_service_class: invoice_service_class)

        result = service.call(payment: payment, cause: cause, redirect_url: redirect_url, webhook_url: webhook_url)

        expect(result.success).to eq(true)
        expect(result.redirect_url).to eq(page_url)
        expect(result.error).to be_nil
      end
    end

    context 'when payment is invalid' do
      before do
        allow(payment).to receive(:valid?).and_return(false)
        allow(payment.errors).to receive(:full_messages).and_return(['Payment is invalid'])
      end

      it 'returns failure with payment error message' do
        service = described_class.new(invoice_service_class: invoice_service_class)
        result = service.call(payment: payment, cause: cause, redirect_url: redirect_url, webhook_url: webhook_url)

        expect(result.success).to eq(false)
        expect(result.error).to eq('Failed to save payment: Payment is invalid')
      end
    end

    context 'when invoice creation fails' do
      let(:invoice_success) { false }
      let(:invoice_error) { 'Invoice creation error' }

      it 'returns failure with invoice error message' do
        service = described_class.new(invoice_service_class: invoice_service_class)
        allow(payment).to receive(:valid?).and_return(true)

        result = service.call(payment: payment, cause: cause, redirect_url: redirect_url, webhook_url: webhook_url)

        expect(result.success).to eq(false)
        expect(result.error).to eq('Invoice creation error')
      end
    end

    context 'when payment save fails' do
      before do
        allow(payment).to receive(:valid?).and_return(true)
        allow(payment).to receive(:save).and_return(false)
        allow(payment.errors).to receive(:full_messages).and_return(['Failed to save payment'])
      end

      it 'returns failure with payment save error message' do
        service = described_class.new(invoice_service_class: invoice_service_class)
        allow(payment).to receive(:reference=).with(invoice_id)

        result = service.call(payment: payment, cause: cause, redirect_url: redirect_url, webhook_url: webhook_url)

        expect(result.success).to eq(false)
        expect(result.error).to eq('Failed to save payment: Failed to save payment')
      end
    end
  end
end
