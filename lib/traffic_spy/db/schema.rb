require "sequel"

DB = Sequel.connect("postgres://localhost/traffic_spy")

DB.create_table :actions unless DB.table_exists?(:actions) do
  primary_key :id
  foreign_key :source_id
  foreign_key :url_id
  DateTime :requested_at
  Integer :responded_in
  foreign_key :referrer_id
  String :request_type
  foreign_key :event_id
  foreign_key :user_agent_id
  foreign_key :resolution_id
  foreign_key :ip_id
  DateTime :created_at
  DateTime :updated_at
end

DB.create_table :sources unless DB.table_exists?(:sources) do
  primary_key :id
  String :identifier
  String :root_url
  DateTime :created_at
  DateTime :updated_at
end

DB.create_table :urls unless DB.table_exists?(:urls) do
  primary_key :id
  String :url
  DateTime :created_at
  DateTime :updated_at
end

DB.create_table :user_agents unless DB.table_exists?(:user_agents) do
  primary_key :id
  String :platform #ua.device.platform
  String :operating_system #ua.device.operating_system
  String :engine_browser #ua.device.engine.browser
  String :engine #ua.device.engine
  DateTime :created_at
  DateTime :updated_at
end

DB.create_table :resolutions unless DB.table_exists?(:resolutions) do
  primary_key :id
  String :width
  String :height
  DateTime :created_at
  DateTime :updated_at
end

DB.create_table :ips unless DB.table_exists?(:ips) do
  primary_key :id
  String :address
  DateTime :created_at
  DateTime :updated_at
end

DB.create_table :referrers unless DB.table_exists?(:referrers) do
  primary_key :id
  String :url
  DateTime :created_at
  DateTime :updated_at
end

DB.create_table :events unless DB.table_exists?(:events) do
  primary_key :id
  String :name
  DateTime :created_at
  DateTime :updated_at
end

DB.create_table :campaigns unless DB.table_exists?(:campaigns) do
  primary_key :id
  String :name
  foreign_key :event_id
  DateTime :created_at
  DateTime :updated_at
end