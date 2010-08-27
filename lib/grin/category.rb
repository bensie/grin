module Grin
  class Category < Client

    def initialize(data)
      data.each do |key, value|
        instance_variable_set("@#{key}", value)
        Category.instance_eval do
          attr_reader key.to_sym
        end
      end
    end

    def albums
      albums = []
      get('albums.json').select { |album| album['category']['id'] == id  }.each { |album| albums << Album.new(album) }
      return albums
    end

    def destroy
      delete("categories/#{id}.json")
    end

  end
end