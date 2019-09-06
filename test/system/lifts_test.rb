require "application_system_test_case"

class LiftsTest < ApplicationSystemTestCase
  setup do
    @lift = lifts(:one)
  end

  test "visiting the index" do
    visit lifts_url
    assert_selector "h1", text: "Lifts"
  end

  test "creating a Lift" do
    visit lifts_url
    click_on "New Lift"

    fill_in "Name", with: @lift.name
    click_on "Create Lift"

    assert_text "Lift was successfully created"
    click_on "Back"
  end

  test "updating a Lift" do
    visit lifts_url
    click_on "Edit", match: :first

    fill_in "Name", with: @lift.name
    click_on "Update Lift"

    assert_text "Lift was successfully updated"
    click_on "Back"
  end

  test "destroying a Lift" do
    visit lifts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Lift was successfully destroyed"
  end
end
