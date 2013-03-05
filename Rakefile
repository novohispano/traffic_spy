require "bundler/gem_tasks"
Bundler.require

desc "Create payloads."
task :payloads do
  10.times do 
    articles = %w(blog article news jorge)
    a = articles.sample
    sources = %w(jumpstartlab facebook google jorge blair tacobell friendster)
    b = sources.sample
    events = %w(SociaLogin HappyDay SadDay DubiousDay TacoDay 5deMayoDay)
    c = events.sample

    `curl -i -d 'payload={"url":"http://#{b}.com/#{a}","requestedAt":"#{Time.now}","respondedIn":#{(1..100).to_a.sample},"referredBy":"http://#{sources.sample}.com","requestType":"GET","parameters":[],"eventName": "#{c}","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"#{(600..1200).to_a.sample}","resolutionHeight":"#{(600..1200).to_a.sample}","ip":"#{(1..255).to_a.sample}.#{(1..255).to_a.sample}.#{(1..255).to_a.sample}.211"}' http://localhost:9393/sources/#{b}/data`
    sleep 0.2
  end
end

desc "Create sources."
task :sources do
  sources = %w(jumpstartlab facebook google jorge blair tacobell friendster)
  sources.each do |source|
    `curl -i -d 'identifier=#{source}&rootUrl=http://#{source}.com' http://localhost:9393/sources`
  end
end

desc "Reset database"
task :resetdb do
  DB.tables.each do |table|
    DB.drop_table(table)
    puts "#{table} reset"
  end
end

#   desc "Prep the test database"
#   task :test_prep do
#     Sequel.extension :migration
#     database_file = 'db/traffic_spy-test.sqlite3'
#     system("rm #{database_file}")
#     database = Sequel.sqlite database_file
#     Sequel::Migrator.run(database, "db/migrations")
#   end

#   desc "Reset database"
#   task :reset => [:setup] do
#     Sequel::Migrator.run(@database, "db/migrations", :target => 0)
#     Sequel::Migrator.run(@database, "db/migrations")
#   end

#   task :setup do
#     Sequel.extension :migration

#     if ENV["TRAFFIC_SPY_ENV"] == "test"
#       database_file = 'db/traffic_spy-test.sqlite3'
#       @database = Sequel.sqlite database_file
#     else
#       @database = Sequel.postgres "traffic_spy"
#     end

#   end
# end

# THIS SPACE RESERVED FOR EVALUATIONS
#
#
#
#
# THIS SPACE RESERVED FOR EVALUATIONS
