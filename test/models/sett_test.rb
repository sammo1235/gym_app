require 'test_helper'

class SettTest < ActiveSupport::TestCase
  test '#workload calculates volume of sett' do
    default_workout

    assert_equal 200, @workout.setts.first.workload
    assert_equal 150, @workout.setts.second.workload
  end

  test 'Sett.user_best_for_lift gives user PB set for a given lift' do
    default_workout

    assert_equal 200, Sett.user_best_for_lift(@user, @squat)

    assert_difference 'Sett.user_best_for_lift(@user, @squat)', 20 do
      @workout.setts.first.update(weight: 220)
    end
  end

  test 'Sett.user_best_for_lift also works with lift name only' do
    default_workout

    assert_equal 200, Sett.user_best_for_lift(@user, 'Back Squat')
  end
end
