ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include FactoryBot::Syntax::Methods

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
  end
end
