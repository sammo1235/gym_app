user = User.find_or_create_by(name: "Luna", bodyweight: 60, email: "sam@hop.com")
lift = Lift.find_or_create_by(name: "Squat")

# create essentially a workout with its nested sets and ting
workout_1 = WorkOut.create(type: "Legs", user: user)

workload = 0
sets = 0

20.times do |a|
    set = WorkUnit.create(reps: rand(1..20), weight: rand(20..150), user: user, lift: lift, work_out: workout_1)
    workload += set.workload
    sets += 1
end

workout_1.total_workload = workload
workout_1.total_sets = sets
workout_1.save

# do the same as above but for a workout a week ago

workout_2 = WorkOut.create(type: "Legs", user: user, created_at: 1.week.ago)

workload_2 = 0
sets_2 = 0
20.times do |a|
    set = WorkUnit.create(reps: rand(1..20), weight: rand(20..150), user: user, lift: lift, work_out: workout_2, created_at: 1.week.ago)
    workload_2 += set.workload
    sets_2 += 1
end

workout_2.total_workload = workload_2
workout_2.total_sets = sets_2
workout_2.save