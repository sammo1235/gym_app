require 'test_helper'

class WorkoutTest < ActiveSupport::TestCase
  test 'it calculates total workload of a workout' do
    workout = create(:workout)
    workout.setts << Sett.create(weight: 100, reps: 10, lift: create(:lift))
    workout.setts << Sett.create(weight: 200, reps: 5, lift: create(:lift))
    assert_equal 2000, workout.total_workload
  end

  test '#prepared_variant makes variant prettier for display' do
    workout = Workout.create(variant: 5)

    assert_equal 'Full body', workout.prepared_variant
  end
end
