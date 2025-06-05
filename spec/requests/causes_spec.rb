# spec/requests/causes_spec.rb
require 'rails_helper'

RSpec.describe "Causes", type: :request do
  let!(:tag1) { create(:tag) }
  let!(:tag2) { create(:tag) }
  let!(:cause1) { create(:cause, title: "Help Children", status: "active", tags: [tag1]) }
  let!(:cause2) { create(:cause, title: "Save Nature", status: "completed", tags: [tag2]) }
  let!(:cause3) { create(:cause, title: "Help Animals", status: "active", tags: [tag1, tag2]) }
  
  let(:valid_attributes) do
    attributes_for(:cause).merge(
      image: fixture_file_upload(Rails.root.join('spec/fixtures/files/sample.jpg'), 'image/jpeg')
    )
  end

  let(:invalid_attributes) { { title: "", description: "" } }

  describe "GET /index" do
    it "renders a successful response" do
      get causes_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(cause1.title)
      expect(response.body).to include(cause2.title)
    end

    it "filters causes by title" do
      get causes_path, params: { title: "Help" }
      expect(response.body).to include(cause1.title)
      expect(response.body).to include(cause3.title)
      expect(response.body).not_to include(cause2.title)
    end

    it "filters causes by status" do
      get causes_path, params: { status: "completed" }
      expect(response.body).to include(cause2.title)
      expect(response.body).not_to include(cause1.title)
    end

    it "filters causes by tag_id" do
      get causes_path, params: { tag_id: tag1.id }
      expect(response.body).to include(cause1.title)
      expect(response.body).to include(cause3.title)
      expect(response.body).not_to include(cause2.title)
    end
  end

  describe "GET /show" do
    let!(:comment1) { create(:comment, cause: cause1, created_at: 1.day.ago) }
    let!(:comment2) { create(:comment, cause: cause1, created_at: Time.now) }

    it "renders a successful response" do
      get cause_path(cause1)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(cause1.title)
      
      expect(response.body).to include(comment1.content)
      expect(response.body).to include(comment2.content)
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_cause_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      get edit_cause_path(cause1)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(cause1.title)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Cause" do
        expect {
          post causes_path, params: { cause: valid_attributes }
        }.to change(Cause, :count).by(1)

        expect(response).to redirect_to(cause_path(Cause.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Cause" do
        expect {
          post causes_path, params: { cause: invalid_attributes }
        }.not_to change(Cause, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) { { title: "Updated Title" } }

      it "updates the requested cause" do
        patch cause_path(cause1), params: { cause: new_attributes }
        cause1.reload
        expect(cause1.title).to eq("Updated Title")
        expect(response).to redirect_to(cause_path(cause1))
      end
    end

    context "with invalid parameters" do
      it "does not update the cause" do
        patch cause_path(cause1), params: { cause: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested cause" do
      cause = create(:cause)
      expect {
        delete cause_path(cause)
      }.to change(Cause, :count).by(-1)

      expect(response).to redirect_to(causes_path)
      expect(response).to have_http_status(:see_other)
    end
  end
end
