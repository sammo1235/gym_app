# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

lifts = %w[
  Squat
  Bench
  Deadlift
  Row
]

lifts.each {|l| Lift.find_or_create_by(name: l)}

20.times do
  workout = Workout.create(variant: rand(7), notes: '')

  rand(15).times do
    sett = Sett.create(reps: rand(1..10), weight: rand(5..100), lift: Lift.find(rand(1..4)), workout_id: workout.id)
    workout.setts << sett
  end
end