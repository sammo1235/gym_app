namespace :db do
    desc 'Load the seed data'
    task :seed => :environment do
        seed = File.join(Rails.root, 'db', 'seeds.rb')
        load(seed) if File.exist?(seed)
    end
end