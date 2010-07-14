module Grin
  class Album < Client
    
    def initialize(data, auth_string)
      data.each do |key, value|
        instance_variable_set("@#{key}", value)
        Album.instance_eval do
          attr_reader key.to_sym
        end
      end
      @auth_string = auth_string
    end
    
    def photos
      photos = []
      get("albums/#{id}/photos.json").each { |photo| photos << Photo.new(photo, @auth_string) }
      return photos
    end
    
    def photo(photo_id)
      if photo = get("albums/#{id}/photos/#{photo_id}.json")
        return Photo.new(photo, @auth_string)
      end
    end
    
    def create_photo(image_data)
      post("albums/#{id}/photos.json", { :photo => { :image => image_data } })
    end
    
  end
end