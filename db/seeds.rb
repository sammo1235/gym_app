# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

LIFTS = [
  "Back Squat",
  "Bench Press",
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

def create_lifts
  LIFTS.each {|l| Lift.find_or_create_by(name: l)}
end

def create_workout(user)
  workout = Workout.create(variant: rand(7), notes: '', user: user)

  rand(15).times do
    sett = Sett.create(reps: rand(1..10), weight: rand(5..200), lift: Lift.find(rand(1..LIFTS.count-1)), workout_id: workout.id)
    workout.setts << sett
  end
end

def create_user
  user = User.create!(
  email: Faker::Internet.email,
  username: "#{Faker::Name.name.split(/\s/).map(&:downcase).join('_')}#{rand(500..3000)}",
  age: rand(15..90),
  gender: rand(0..1),
  bodyweight: rand(45..150),
  password: Faker::Company.bs.gsub(/\s/, '')
  )

  7.times do
    create_workout(user)    
  end
end

def create_me
  user = User.find_by(username: 'sammo1235') || User.create!(
    email: 'sammo@gmail.com',
    username: 'sammo1235',
    age: 28,
    gender: 0,
    bodyweight: 90,
    password: 'password'
    )

  7.times do
   create_workout(user)
  end
end

def workouts_for_everyone
  User.all.each do |user|
    7.times do
      create_workout(user)
    end
  end
end

workouts_for_everyone