require "application_system_test_case"

class WorkUnitsTest < ApplicationSystemTestCase
  setup do
    @work_unit = work_units(:one)
  end

  test "visiting the index" do
    visit work_units_url
    assert_selector "h1", text: "Work Units"
  end

  test "creating a Work unit" do
    visit work_units_url
    click_on "New Work Unit"

    fill_in "Lift", with: @work_unit.lift_id
    fill_in "Reps", with: @work_unit.reps
    fill_in "User", with: @work_unit.user_id
    fill_in "Weight", with: @work_unit.weight
    click_on "Create Work unit"

    assert_text "Work unit was successfully created"
    click_on "Back"
  end

  test "updating a Work unit" do
    visit work_units_url
    click_on "Edit", match: :first

    fill_in "Lift", with: @work_unit.lift_id
    fill_in "Reps", with: @work_unit.reps
    fill_in "User", with: @work_unit.user_id
    fill_in "Weight", with: @work_unit.weight
    click_on "Update Work unit"

    assert_text "Work unit was successfully updated"
    click_on "Back"
  end

  test "destroying a Work unit" do
    visit work_units_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Work unit was successfully destroyed"
  end
end
