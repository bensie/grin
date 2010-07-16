module Grin
  class Category < Client
    
    def initialize(data, auth_string)
      data.each do |key, value|
        instance_variable_set("@#{key}", value)
        Category.instance_eval do
          attr_reader key.to_sym
        end
      end
      @auth_string = auth_string
    end
    
  end
end