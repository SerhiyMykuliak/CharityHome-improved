require 'rails_helper'

RSpec.describe "Payments", type: :request do
  let!(:cause) { create(:cause) }

  let(:valid_attributes) do
    {
      amount: 100.0,
      username: "John Doe",
      email: "john@example.com",
      description: "Donation"
    }
  end

  let(:invalid_attributes) do
    {
      amount: nil,
      username: "",
      email: "invalid-email",
      description: ""
    }
  end

  describe "GET /new" do
    it "returns a successful response and renders the new payment form" do
      get new_cause_payment_path(cause)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      before do
        result_double = double(
          success: true,
          redirect_url: "https://redirect.example.com"
        )
        
        allow_any_instance_of(Payments::CreatePaymentService).to receive(:call).and_return(result_double)
      end

      it "redirects to the redirect_url after successful payment creation" do
        post cause_payments_path(cause), params: { payment: valid_attributes }
        expect(response).to redirect_to("https://redirect.example.com")
      end
    end

    context "with invalid parameters" do
      before do
        result_double = double(success: false, error: "Payment creation failed")
        allow_any_instance_of(Payments::CreatePaymentService).to receive(:call).and_return(result_double)
      end


      it "redirects back to the new payment form and sets flash error" do
        post cause_payments_path(cause), params: { payment: invalid_attributes }
        expect(flash[:error]).to eq("Payment creation failed")
        expect(response).to redirect_to(new_cause_payment_path(cause))
      end
    end
  end
end
