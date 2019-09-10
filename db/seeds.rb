require 'neo4j'
require 'rubygems'

100.times do |a|
    WorkUnit.create(reps: rand(1..20), weight: rand(20..150), user: "Sam", lift: "Bench")
end
