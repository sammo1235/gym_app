require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'deleting user account will also delete workouts and sets, but not lifts' do
    default_workout

    assert_difference 'Workout.count', -1 do
      assert_difference 'Sett.count', -3 do
        assert_no_difference 'Lift.count' do
          @user.destroy
        end
      end
    end
  end
end
