require 'test_helper'

class SettTest < ActiveSupport::TestCase
  setup do
    default_workout
  end

  test '#workload calculates volume of sett' do
    assert_equal 200, @workout.setts.first.workload
    assert_equal 150, @workout.setts.second.workload
  end

  test 'Sett.user_best_for_lift gives user PB set for a given lift' do
    assert_equal 200, Sett.user_best_for_lift(@user, @squat)

    assert_difference 'Sett.user_best_for_lift(@user, @squat)', 20 do
      @workout.setts.first.update(weight: 220)
    end
  end

  test 'Sett.user_best_for_lift also works with lift name only' do
    assert_equal 200, Sett.user_best_for_lift(@user, 'Back Squat')
  end

  test 'Sett.user_best gives projected best 1RM for sets with 4-6 reps...' do
    Workout.new(variant: 0, user: @user).tap do |workout|
      workout.setts << Sett.create(weight: 190, reps: 5, lift: @squat)
      workout.save
    end

    assert_equal 222.69, Sett.user_best_for_lift(@user, @squat)
  end

  test '...but other rep ranges dont affect it' do
    Workout.new(variant: 0, user: @user).tap do |workout|
      workout.setts << Sett.create(weight: 160, reps: 10, lift: @squat)
      workout.save
    end

    assert_equal 200, Sett.user_best_for_lift(@user, @squat)
  end

  test "Sett.user_best raises error if lift doesn't exist" do
    assert_raises ActiveRecord::RecordNotFound do
      Sett.user_best_for_lift(@user, 'Chawomba')
    end
  end
end
