require "test_helper"

class VolunteersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @volunteer = volunteers(:one)
  end

  test "should get index" do
    get volunteers_url
    assert_response :success
  end

  test "should get new" do
    get new_volunteer_url
    assert_response :success
  end

  test "should create volunteer" do
    assert_difference("Volunteer.count") do
      post volunteers_url, params: { volunteer: { birth_date: @volunteer.birth_date, city: @volunteer.city, description: @volunteer.description, email: @volunteer.email, facebook_url: @volunteer.facebook_url, first_name: @volunteer.first_name, instagram_url: @volunteer.instagram_url, last_name: @volunteer.last_name, phone_number: @volunteer.phone_number, twitter_url: @volunteer.twitter_url } }
    end

    assert_redirected_to volunteer_url(Volunteer.last)
  end

  test "should show volunteer" do
    get volunteer_url(@volunteer)
    assert_response :success
  end

  test "should get edit" do
    get edit_volunteer_url(@volunteer)
    assert_response :success
  end

  test "should update volunteer" do
    patch volunteer_url(@volunteer), params: { volunteer: { birth_date: @volunteer.birth_date, city: @volunteer.city, description: @volunteer.description, email: @volunteer.email, facebook_url: @volunteer.facebook_url, first_name: @volunteer.first_name, instagram_url: @volunteer.instagram_url, last_name: @volunteer.last_name, phone_number: @volunteer.phone_number, twitter_url: @volunteer.twitter_url } }
    assert_redirected_to volunteer_url(@volunteer)
  end

  test "should destroy volunteer" do
    assert_difference("Volunteer.count", -1) do
      delete volunteer_url(@volunteer)
    end

    assert_redirected_to volunteers_url
  end
end
