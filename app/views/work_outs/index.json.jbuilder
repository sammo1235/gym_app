json.array! @work_outs do |workout|
  json.id workout.id
  json.type workout.type
  json.created_at workout.created_at
  json.total_workload workout.total_workload
  json.total_sets workout.total_sets
  json.user workout.user

  json.work_units(workout.work_unit) do |unit|
    json.id unit.id
    json.lift unit.lift
    json.weight unit.weight
    json.reps unit.reps
    json.workload unit.workload

  end
end
