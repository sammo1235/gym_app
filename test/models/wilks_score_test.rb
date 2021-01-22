require 'test_helper'

class WilksScoreTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
    @squat = Lift.create(name: 'Back Squat')
    @bench = Lift.create(name: 'Bench Press')
    @deadlift = Lift.create(name: 'Deadlift')
  end

  def default_workout
    @workout = Workout.new(variant: 5, user: @user).tap do |workout|
      workout.setts << Sett.create(lift: @squat, weight: 200, reps: 1)
      workout.setts << Sett.create(lift: @bench, weight: 150, reps: 1)
      workout.setts << Sett.create(lift: @deadlift, weight: 250, reps: 1)
      workout.save
    end
    @wilks = WilksCalc.send(@user.gender, @user.bodyweight, 600)
    assert_equal @user.best_wilks, @wilks
  end

  test "it should generate the correct wilks score with 1RMs" do
    default_workout
    wilks = WilksCalc.send(@user.gender, @user.bodyweight, 600)
    assert_equal @user.best_wilks, wilks
  end

  test "it should generate the correct wilks score with 5RMs" do
    workout = Workout.new(variant: 5, user: @user).tap do |workout|
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

    wilks = WilksCalc.send(@user.gender, @user.bodyweight, projected_1rms.sum)
    assert_equal @user.best_wilks, wilks
  end

  test "it doesn't create a wilks score if reps are out of bounds" do
    workout = Workout.new(variant: 5, user: @user).tap do |workout|
      workout.setts << Sett.create(lift: @squat, weight: 100, reps: 12)
      workout.setts << Sett.create(lift: @bench, weight: 120, reps: 7)
      workout.setts << Sett.create(lift: @deadlift, weight: 250, reps: 4)
      workout.save
    end

    refute @user.best_wilks
  end

  test "it shouldn't create a WilksScore without all three lifts present" do
    Workout.new(variant: 5, user: @user).tap do |workout|
      workout.setts << Sett.create(lift: @squat, weight: 200, reps: 1)
      workout.setts << Sett.create(lift: @bench, weight: 150, reps: 1)
      workout.save
    end

    refute @user.best_wilks
  end

  test "it should update wilks score with better set" do
    default_workout

    Workout.new(variant: 5, user: @user).tap do |workout|
      workout.setts << Sett.create(lift: @squat, weight: 205, reps: 1)
      workout.save
    end

    wilks = WilksCalc.send(@user.gender, @user.bodyweight, 605)
    assert_equal @user.best_wilks, wilks
  end

  test "it shouldn't create a lower wilks with a lower new total" do
    default_workout

    Workout.new(variant: 5, user: @user).tap do |workout|
      workout.setts << Sett.create(lift: @squat, weight: 190, reps: 1)
      workout.setts << Sett.create(lift: @bench, weight: 80, reps: 5)
      workout.setts << Sett.create(lift: @deadlift, weight: 120, reps: 6)
      workout.save
    end

    assert_equal @user.best_wilks, @wilks
  end

  test "lifts other than S/B/D aren't counted" do
    @dumbell_press = Lift.create(name: 'Dumbell Press')
    Workout.new(variant: 5, user: @user).tap do |workout|
      workout.setts << Sett.create(lift: @dumbell_press, weight: 30, reps: 1)
      workout.setts << Sett.create(lift: @dumbell_press, weight: 35, reps: 5)
      workout.setts << Sett.create(lift: @dumbell_press, weight: 40, reps: 6)
      workout.save
    end

    refute @user.best_wilks
  end

  test "new wilks will be created if sett is edited" do
    default_workout

    assert_difference '@user.wilks_scores.count', 1 do
      @workout.setts.first.update(weight: 210)
    end

    new_wilks = WilksCalc.send(@user.gender, @user.bodyweight, 610)

    assert_equal @user.best_wilks, new_wilks
  end
end
