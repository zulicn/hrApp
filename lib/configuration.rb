module Conf
  class Configuration
    def self.reload
      @@cache = YAML::load_file('config/configuration.yml')      
    end
    
    def self.get(group, name, default=nil)
      if (@@cache[group.to_s][name.to_s].nil?)
        return default
      else
        return @@cache[group.to_s][name.to_s]
      end
    end
    
    def self.set(group, name, value)
      if (@@cache[group.to_s].has_key?(name.to_s))
        @@cache[group.to_s][name.to_s] = value
      end      
    end    
  end
end