require "sequel"

DB = Sequel.postgres("traffic_spy")

DB.create_table :actions do
  primary_key :id
  foreign_key :source_id
  foreign_key :url_id
  DateTime :requested_at
  Integer :responded_in
  foreign_key :referrer_id
  String :request_type
  foreign_key :event_id
  foreign_key :user_agent_id
  foreign_key :resolutions_id
  foreign_key :ip_id
end

DB.create_table :sources do
  primary_key :id
  String :identifier
  String :root_url
end

DB.create_table :urls do
  primary_key :id
  string :url
end

DB.create_table :user_agents do
  primary_key :id
  String :agent_string
  String :OS
  String :browser
end

DB.create_table :resolutions do
  primary_key :id
  String :width
  String :height
end

DB.create_table :ips do
  primary_key :id
  String :address
end

DB.create_table :referrers do
  primary_key :id
  String :url
end

DB.create_table :events do
  primary_key :id
  String :name
end

DB.create_table :campaigns do
  primary_key :id
  String :name
  foreign_key :event_id
end