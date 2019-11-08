json.extract! work_out, :id, :type, :created_at, :total_workload, :total_sets, :user

  json.work_units(work_out.work_unit) do |unit|
  json.id unit.id
  json.lift unit.lift
  json.weight unit.weight
  json.reps unit.reps
  json.workload unit.workload
end

json.url work_out_url(work_out, format: :json)
