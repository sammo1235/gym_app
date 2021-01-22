require 'test_helper'

class WorkoutTest < ActiveSupport::TestCase
  test 'it calculates total workload of a workout' do
    default_workout

    assert_equal 600, @workout.total_workload
  end

  test '#prepared_variant makes variant prettier for display' do
    workout = Workout.create(variant: 5, user: create(:user))

    assert_equal 'Full body', workout.prepared_variant
  end

  test 'deleting a workout deletes associated setts' do
    default_workout

    assert_difference 'Sett.count', -3 do
      @workout.destroy
    end
  end
end
