# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

lifts = [
  "Squat",
  "Bench",
  "Deadlift",
  "Row",
  "Incline Dumbell Press",
  "Romainian Deadlift",
  "Dumbell Press",
  "Dumbell Row",
  "Machine OHP",
  "Lat Pulldown",
  "Pullups",
  "Leg Press",
  "Dips"
]

lifts.each {|l| Lift.find_or_create_by(name: l)}

20.times do
  user = User.create!(
  email: Faker::Internet.email,
  username: "#{Faker::Name.name.split(/\s/).map(&:downcase).join('_')}#{rand(500..3000)}",
  age: rand(15..90),
  gender: rand(0..1),
  bodyweight: rand(45..150),
  wilks_score: rand(100..500.0).round(2),
  password: Faker::Company.bs.gsub(/\s/, '')
  )

  7.times do
    workout = Workout.create(variant: rand(7), notes: '', user: user)

    rand(15).times do
      sett = Sett.create(reps: rand(1..10), weight: rand(5..200), lift: Lift.find(rand(1..lifts.count-1)), workout_id: workout.id)
      workout.setts << sett
    end
  end
end
