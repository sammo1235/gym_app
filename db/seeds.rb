user = User.create(name: "Sam", bodyweight: 95, email: "sam@hop.com")
lift = Lift.create(name: "Squat")

# create essentially a workout with its nested sets and 
workout_1 = WorkOut.create(type: "Legs", user: user)

workload = 0

20.times do |a|
    set = WorkUnit.create(reps: rand(1..20), weight: rand(20..150), user: user, lift: lift, work_out: workout_1)
    workload += set.workload
end

workout_1.total_workload = workload
workout_1.save

workout_2 = WorkOut.create(type: "Legs", user: user, created_at: 1.week.ago)

workload_2 = 0
20.times do |a|
    set = WorkUnit.create(reps: rand(1..20), weight: rand(20..150), user: user, lift: lift, work_out: workout_2, created_at: 1.week.ago)
    workload_2 += set.workload
end

workout_2.total_workload = workload_2
workout_2.save