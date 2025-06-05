# spec/requests/gallery_images_spec.rb
require 'rails_helper'

RSpec.describe "GalleryImages", type: :request do
  let!(:gallery_image1) { create(:gallery_image) }
  let!(:gallery_image2) { create(:gallery_image) }

  let(:valid_attributes) do
    attributes_for(:gallery_image).merge(
      image: fixture_file_upload(Rails.root.join('spec/fixtures/files/sample.jpg'), 'image/jpeg')
    )
  end

  let(:invalid_attributes) { { title: "", image: nil } }

  describe "GET /index" do
    it "returns a successful response and includes gallery images titles" do
      get gallery_images_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(gallery_image1.title)
      expect(response.body).to include(gallery_image2.title)
    end
  end

  describe "GET /new" do
    it "returns a successful response" do
      get new_gallery_image_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /edit" do
    it "returns a successful response and includes the gallery image title" do
      get edit_gallery_image_path(gallery_image1)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(gallery_image1.title)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new GalleryImage" do
        expect {
          post gallery_images_path, params: { gallery_image: valid_attributes }
        }.to change(GalleryImage, :count).by(1)

        expect(response).to redirect_to(gallery_images_path)
      end
    end

    context "with invalid parameters" do
      it "does not create a new GalleryImage and returns unprocessable_entity status" do
        expect {
          post gallery_images_path, params: { gallery_image: invalid_attributes }
        }.not_to change(GalleryImage, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) { { title: "Updated Title" } }

      it "updates the requested GalleryImage" do
        patch gallery_image_path(gallery_image1), params: { gallery_image: new_attributes }
        gallery_image1.reload
        expect(gallery_image1.title).to eq("Updated Title")
        expect(response).to redirect_to(gallery_images_path)
      end
    end

    context "with invalid parameters" do
      it "does not update the GalleryImage and returns unprocessable_entity status" do
        patch gallery_image_path(gallery_image1), params: { gallery_image: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested GalleryImage" do
      gallery_image = create(:gallery_image)
      expect {
        delete gallery_image_path(gallery_image)
      }.to change(GalleryImage, :count).by(-1)

      expect(response).to redirect_to(gallery_images_path)
      expect(response).to have_http_status(:see_other)
    end
  end
end
