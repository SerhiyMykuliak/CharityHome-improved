require 'rails_helper'

RSpec.describe "Webhooks", type: :request do
  describe "POST /webhooks/monopay" do
    let!(:cause) { create(:cause, collected_amount: 0) }
    let!(:payment) { create(:payment, cause: cause, amount: 900, status: "pending", reference: "inv-123") }

    let(:valid_payload) do
      {
        invoiceId: payment.reference,
        status: "success"
      }.to_json
    end

    context "when the webhook is valid" do
      before do
        validator = instance_double(MonopayRuby::Webhooks::Validator, valid?: true)
        allow(MonopayRuby::Webhooks::Validator).to receive(:new).and_return(validator)
      end

      it "updates the payment and cause, and returns :ok" do
        expect {
          post webhooks_monopay_path,
               params: valid_payload,
               headers: { "CONTENT_TYPE" => "application/json" }
        }.to change { payment.reload.status }.from("pending").to("success")

        expect(response).to have_http_status(:ok)
        expect(cause.reload.collected_amount).to eq(payment.amount)
      end

      it "returns :not_found when payment is missing" do
        payment.destroy

        post webhooks_monopay_path,
             params: valid_payload,
             headers: { "CONTENT_TYPE" => "application/json" }

        expect(response).to have_http_status(:not_found)
      end
    end

    context "when the webhook is invalid" do
      before do
        validator = instance_double(MonopayRuby::Webhooks::Validator, valid?: false)
        allow(MonopayRuby::Webhooks::Validator).to receive(:new).and_return(validator)
      end

      it "does not process and returns :unauthorized" do
        post webhooks_monopay_path,
             params: valid_payload,
             headers: { "CONTENT_TYPE" => "application/json" }

        expect(response).to have_http_status(:unauthorized)
        expect(payment.reload.status).to eq("pending")
      end
    end
  end
end
