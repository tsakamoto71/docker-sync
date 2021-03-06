require "yaml"
require 'dotenv'

module ConfigTemplate
  def self.interpolate_config_string(config_string)
      env_hash = {}
      ENV.each {|k,v| env_hash[k.to_sym] = v }
      config_string.gsub!('${', '%{')
      config_string = config_string % env_hash
      return YAML.load(config_string)
  end
  def self.interpolate_config_file(config_path)
      # assuming the checks that file exist have already been performed
      config_string = File.read(config_path)
      self.interpolate_config_string(config_string)
  end
end
