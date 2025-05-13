require "application_system_test_case"

class VolunteersTest < ApplicationSystemTestCase
  setup do
    @volunteer = volunteers(:one)
  end

  test "visiting the index" do
    visit volunteers_url
    assert_selector "h1", text: "Volunteers"
  end

  test "should create volunteer" do
    visit volunteers_url
    click_on "New volunteer"

    fill_in "Birth date", with: @volunteer.birth_date
    fill_in "City", with: @volunteer.city
    fill_in "Description", with: @volunteer.description
    fill_in "Email", with: @volunteer.email
    fill_in "Facebook url", with: @volunteer.facebook_url
    fill_in "First name", with: @volunteer.first_name
    fill_in "Instagram url", with: @volunteer.instagram_url
    fill_in "Last name", with: @volunteer.last_name
    fill_in "Phone number", with: @volunteer.phone_number
    fill_in "Twitter url", with: @volunteer.twitter_url
    click_on "Create Volunteer"

    assert_text "Volunteer was successfully created"
    click_on "Back"
  end

  test "should update Volunteer" do
    visit volunteer_url(@volunteer)
    click_on "Edit this volunteer", match: :first

    fill_in "Birth date", with: @volunteer.birth_date
    fill_in "City", with: @volunteer.city
    fill_in "Description", with: @volunteer.description
    fill_in "Email", with: @volunteer.email
    fill_in "Facebook url", with: @volunteer.facebook_url
    fill_in "First name", with: @volunteer.first_name
    fill_in "Instagram url", with: @volunteer.instagram_url
    fill_in "Last name", with: @volunteer.last_name
    fill_in "Phone number", with: @volunteer.phone_number
    fill_in "Twitter url", with: @volunteer.twitter_url
    click_on "Update Volunteer"

    assert_text "Volunteer was successfully updated"
    click_on "Back"
  end

  test "should destroy Volunteer" do
    visit volunteer_url(@volunteer)
    accept_confirm { click_on "Destroy this volunteer", match: :first }

    assert_text "Volunteer was successfully destroyed"
  end
end
