## gym app ##

lift
id
name

has_many :sets
has_many :workouts, through :sets

workout
id

has_many :sets
has_many :lifts, through: :sets

set
id
reps
weight
ref lift
ref workout

belongs_to :workout
belongs_to :lift