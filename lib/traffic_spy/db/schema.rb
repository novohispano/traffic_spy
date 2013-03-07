require "sequel"

puts "Connecting to Postgres... #{Time.now}"
# DB = Sequel.connect("postgres://localhost/traffic_spy")
DB = Sequel.connect(ENV['DATABASE_URL'])
puts "Connected to DB successfully!"

unless DB.table_exists?(:actions)
  DB.create_table :actions do
    primary_key :id
    foreign_key :source_id
    foreign_key :url_id
    DateTime    :requested_at
    Integer     :responded_in
    foreign_key :referrer_id
    String      :request_type
    foreign_key :event_id
    foreign_key :user_agent_id
    foreign_key :resolution_id
    foreign_key :ip_id
    DateTime    :created_at
    DateTime    :updated_at
  end
end

unless DB.table_exists?(:sources)
  DB.create_table :sources do
    primary_key :id
    String      :identifier
    String      :root_url
    DateTime    :created_at
    DateTime    :updated_at
  end
end

unless DB.table_exists?(:urls)
  DB.create_table :urls do
    primary_key :id
    String      :url
    String      :host
    String      :path
    DateTime    :created_at
    DateTime    :updated_at
  end
end

unless DB.table_exists?(:agents)
  DB.create_table :agents do
    primary_key :id
    String      :operating_system
    String      :browser
    DateTime    :created_at
    DateTime    :updated_at
  end
end

unless DB.table_exists?(:resolutions)
  DB.create_table :resolutions do
    primary_key :id
    String      :width
    String      :height
    DateTime    :created_at
    DateTime    :updated_at
  end
end

unless DB.table_exists?(:ips)
  DB.create_table :ips do
    primary_key :id
    String      :address
    DateTime    :created_at
    DateTime    :updated_at
  end
end

unless DB.table_exists?(:referrers)
  DB.create_table :referrers do
    primary_key :id
    String      :url
    DateTime    :created_at
    DateTime    :updated_at
  end
end

unless DB.table_exists?(:events)
  DB.create_table :events do
    primary_key :id
    String      :name
    DateTime    :created_at
    DateTime    :updated_at
  end
end

unless DB.table_exists?(:campaigns)
  DB.create_table :campaigns do
    primary_key :id
    String      :name
    foreign_key :event_id
    DateTime    :created_at
    DateTime    :updated_at
  end
end
