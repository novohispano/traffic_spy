require "bundler/gem_tasks"
Bundler.require

namespace :setup do
  desc "Run payloads"
  task :payloads do
    5.times do 
      a = %w(jumpstartlab facebook google jorge blair tacobell)
      b = a.sample

      `curl -i -d 'payload={"url":"http://{b}.com/blog","requestedAt":"#{(1900..2020).to_a.sample}-02-11 21:38:10 -0700","respondedIn":37,"referredBy":"http://#{a.sample}.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"#{(1..255).to_a.sample}.29.#{(1..255).to_a.sample}.211"}' http://localhost:4567/sources/#{b}/data`
      sleep 1
    end
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
