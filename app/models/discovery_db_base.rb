class DiscoveryDBBase < ActiveRecord::Base
  self.abstract_class = true
  establish_connection YAML.load_file(File.join(Rails.root, "config", "discovery_database.yml"))[Rails.env.to_s]
end