user = User.create(name: "Sam", bodyweight: 95, email: "sam@hop.com")
lift = Lift.create(name: "Squat")

3.times do |a|
    WorkUnit.create(reps: rand(1..20), weight: rand(20..150), user: user, lift: lift)
end

3.times do |a|
    WorkUnit.create(reps: rand(1..20), weight: rand(20..150), user: user, lift: lift, created_at: 1.week.ago)
end