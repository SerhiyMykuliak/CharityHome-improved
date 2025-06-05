require 'rails_helper'

RSpec.describe "Volunteers", type: :request do
  let(:volunteer) { create(:volunteer) }

  let(:valid_attributes) { attributes_for(:volunteer) }

  let(:valid_attributes) do
    attributes_for(:volunteer).merge(
      avatar: fixture_file_upload(Rails.root.join('spec/fixtures/files/sample.jpg'), 'image/jpeg')
    )
  end

  let(:invalid_attributes) do
    {
      first_name: "",
      last_name: "",
      email: "неправильна-електронна-пошта"
    }
  end

  describe "GET /index" do
    it "renders a successful response" do
      volunteer 
      get volunteers_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(volunteer.first_name)
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get volunteer_path(volunteer)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_volunteer_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      get edit_volunteer_path(volunteer)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Volunteer" do
        expect {
          post volunteers_path, params: { volunteer: valid_attributes }
        }.to change(Volunteer, :count).by(1)

        expect(response).to redirect_to(volunteer_path(Volunteer.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Volunteer" do
        expect {
          post volunteers_path, params: { volunteer: invalid_attributes }
        }.not_to change(Volunteer, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) { { first_name: "Олександр" } }

      it "updates the requested volunteer" do
        patch volunteer_path(volunteer), params: { volunteer: new_attributes }
        volunteer.reload
        expect(volunteer.first_name).to eq("Олександр")
        expect(response).to redirect_to(volunteer_path(volunteer))
      end
    end

    context "with invalid parameters" do
      it "does not update the volunteer" do
        patch volunteer_path(volunteer), params: { volunteer: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested volunteer" do
      volunteer
      expect {
        delete volunteer_path(volunteer)
      }.to change(Volunteer, :count).by(-1)

      expect(response).to redirect_to(volunteers_path)
      expect(response).to have_http_status(:see_other)
    end
  end
end
