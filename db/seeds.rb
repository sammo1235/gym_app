require 'neo4j'
require 'rubygems'
#CREATE (a:User { name : "Luna", email : "luna@hopmail.com", bodyweight : 60 })
Neo4j::Node.new :name=>"Luna", :bodyweight=>60, :email=>"luna@hopmail.com"

=begin
100.times do |a|
    WorkUnit.create(reps: rand(1..20), weight: rand(20..150), user: "Sam", lift: "Bench")
end
=end