module Grin
  class Photo < Client

    def initialize(data)
      data.each do |key, value|
        instance_variable_set("@#{key}", value)
        Photo.instance_eval do
          attr_reader key.to_sym
        end
      end
    end

  end
end