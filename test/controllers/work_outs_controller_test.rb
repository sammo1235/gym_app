require 'test_helper'

class WorkOutsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @work_out = work_outs(:one)
  end

  test "should get index" do
    get work_outs_url
    assert_response :success
  end

  test "should get new" do
    get new_work_out_url
    assert_response :success
  end

  test "should create work_out" do
    assert_difference('WorkOut.count') do
      post work_outs_url, params: { work_out: { created_at: @work_out.created_at, total_workload: @work_out.total_workload, type: @work_out.type, user_id: @work_out.user_id } }
    end

    assert_redirected_to work_out_url(WorkOut.last)
  end

  test "should show work_out" do
    get work_out_url(@work_out)
    assert_response :success
  end

  test "should get edit" do
    get edit_work_out_url(@work_out)
    assert_response :success
  end

  test "should update work_out" do
    patch work_out_url(@work_out), params: { work_out: { created_at: @work_out.created_at, total_workload: @work_out.total_workload, type: @work_out.type, user_id: @work_out.user_id } }
    assert_redirected_to work_out_url(@work_out)
  end

  test "should destroy work_out" do
    assert_difference('WorkOut.count', -1) do
      delete work_out_url(@work_out)
    end

    assert_redirected_to work_outs_url
  end
end
