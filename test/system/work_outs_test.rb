require "application_system_test_case"

class WorkOutsTest < ApplicationSystemTestCase
  setup do
    @work_out = work_outs(:one)
  end

  test "visiting the index" do
    visit work_outs_url
    assert_selector "h1", text: "Work Outs"
  end

  test "creating a Work out" do
    visit work_outs_url
    click_on "New Work Out"

    fill_in "Created at", with: @work_out.created_at
    fill_in "Total workload", with: @work_out.total_workload
    fill_in "Type", with: @work_out.type
    fill_in "User", with: @work_out.user_id
    click_on "Create Work out"

    assert_text "Work out was successfully created"
    click_on "Back"
  end

  test "updating a Work out" do
    visit work_outs_url
    click_on "Edit", match: :first

    fill_in "Created at", with: @work_out.created_at
    fill_in "Total workload", with: @work_out.total_workload
    fill_in "Type", with: @work_out.type
    fill_in "User", with: @work_out.user_id
    click_on "Update Work out"

    assert_text "Work out was successfully updated"
    click_on "Back"
  end

  test "destroying a Work out" do
    visit work_outs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Work out was successfully destroyed"
  end
end
