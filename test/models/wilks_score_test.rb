require 'test_helper'

class WilksScoreTest < ActiveSupport::TestCase
  setup do
    @squat = Lift.create(name: 'Back Squat')
    @bench = Lift.create(name: 'Bench Press')
    @deadlift = Lift.create(name: 'Deadlift')
  end

  def default_workout
    @user = create(:user)
    @workout = Workout.new(variant: 5, user: @user).tap do |workout|
      workout.setts << Sett.create(lift: @squat, weight: 200, reps: 1)
      workout.setts << Sett.create(lift: @bench, weight: 150, reps: 1)
      workout.setts << Sett.create(lift: @deadlift, weight: 250, reps: 1)
      workout.save
    end
  end

  test "it should generate the correct wilks score with 1RMs" do
    default_workout
    wilks = WilksCalc.send(@user.gender, @user.bodyweight, 600)
    assert_equal @user.best_wilks, wilks
  end

  test "it should generate the correct wilks score with 5RMs" do
    user = create(:user)

    workout = Workout.new(variant: 5, user: user).tap do |workout|
      workout.setts << Sett.create(lift: @squat, weight: 200, reps: 5)
      workout.setts << Sett.create(lift: @bench, weight: 150, reps: 5)
      workout.setts << Sett.create(lift: @deadlift, weight: 250, reps: 5)
      workout.save
    end

    projected_1rms = []

    workout.setts.each do |sett|
      if sett.lift == @bench
        projected_1rms << sett.upper_body_projected_1RM
      else
        projected_1rms << sett.lower_body_projected_1RM
      end
    end

    wilks = WilksCalc.send(user.gender, user.bodyweight, projected_1rms.sum)
    assert_equal user.best_wilks, wilks
  end

  test "it shouldn't create a WilksScore without all three lifts present" do
    user = create(:user)
    Workout.new(variant: 5, user: user).tap do |workout|
      workout.setts << Sett.create(lift: @squat, weight: 200, reps: 1)
      workout.setts << Sett.create(lift: @bench, weight: 150, reps: 1)
      workout.save
    end

    refute user.best_wilks
  end

  test "it should update wilks score with better set" do
    default_workout

    wilks = WilksCalc.send(@user.gender, @user.bodyweight, 600)
    assert_equal @user.best_wilks, wilks

    Workout.new(variant: 5, user: @user).tap do |workout|
      workout.setts << Sett.create(lift: @squat, weight: 205, reps: 1)
      workout.save
    end

    wilks = WilksCalc.send(@user.gender, @user.bodyweight, 605)
    assert_equal @user.best_wilks, wilks
  end

  test "it shouldn't create a lower wilks with a lower new total" do
    default_workout

    wilks = WilksCalc.send(@user.gender, @user.bodyweight, 600)
    assert_equal @user.best_wilks, wilks

    Workout.new(variant: 5, user: @user).tap do |workout|
      workout.setts << Sett.create(lift: @squat, weight: 190, reps: 1)
      workout.setts << Sett.create(lift: @bench, weight: 80, reps: 5)
      workout.setts << Sett.create(lift: @deadlift, weight: 120, reps: 6)
      workout.save
    end

    assert_equal @user.best_wilks, wilks
  end
end
