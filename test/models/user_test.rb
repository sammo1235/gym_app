require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
  end

  test 'deleting user account will also delete workouts and sets, but not lifts' do
    @workout = Workout.create(user: @user, variant: 0)
    3.times do
      @workout.setts.create(weight: 90, reps: 10, lift: create(:lift))
    end
    workout_count = Workout.count
    sett_count = Sett.count
    lift_count = Lift.count

    @user.destroy
    assert_equal Workout.count, workout_count - 1
    assert_equal Sett.count, sett_count - 3
    assert_equal Lift.count, lift_count
  end
end
