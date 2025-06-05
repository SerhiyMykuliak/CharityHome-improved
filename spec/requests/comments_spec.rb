# spec/requests/comments_spec.rb
require 'rails_helper'

RSpec.describe CommentsController, type: :request do
  let!(:cause) { create(:cause) }

  let(:valid_attributes) do
    {
      username: "Test User",
      email: "test@example.com",
      content: "This is a test comment"
    }
  end

  let(:invalid_attributes) do
    {
      username: "",
      email: "not-an-email",
      content: ""
    }
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Comment and redirects for HTML" do
        expect {
          post cause_comments_path(cause), params: { comment: valid_attributes }, headers: { "Accept" => "text/html" }
        }.to change(cause.comments, :count).by(1)

        expect(response).to redirect_to(cause)
      end

      it "creates a new Comment and responds with turbo stream" do
        expect {
          post cause_comments_path(cause), params: { comment: valid_attributes }, headers: { "Accept" => "text/vnd.turbo-stream.html" }
        }.to change(cause.comments, :count).by(1)

        expect(response.media_type).to eq("text/vnd.turbo-stream.html")
        expect(response.body).to include("turbo-stream")
      end
    end

    context "with invalid parameters" do
      it "does not create a new Comment and responds with turbo stream update" do
        expect {
          post cause_comments_path(cause), params: { comment: invalid_attributes }, headers: { "Accept" => "text/vnd.turbo-stream.html" }
        }.to_not change(cause.comments, :count)

        expect(response.media_type).to eq("text/vnd.turbo-stream.html")
        expect(response.body).to include("new_comment_form")
      end
    end
  end
end
