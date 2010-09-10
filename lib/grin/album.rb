module Grin
  class Album < Client

    def initialize(data)
      data.each do |key, value|
        instance_variable_set("@#{key}", value)
        Album.instance_eval do
          attr_reader key.to_sym
        end
      end
    end

    def photos
      photos = []
      get("albums/#{id}/photos.json").each { |photo| photos << Photo.new(photo) }
      return photos
    end

    def photo(photo_id)
      photo = get("albums/#{id}/photos/#{photo_id}.json")
      if photo.respond_to?(:[]) && photo['status'] == 'error'
        return photo
      else
        Photo.new(photo)
      end
    end

    def create_photo(image_data)
      post("albums/#{id}/photos.json", { :photo => { :image => image_data } })
    end

    def find_or_create_photo(filename, image_data)
      if photo = photos.select { |p| p.filename == filename }.pop
        return photo
      else
        create_photo(image_data)
      end
    end

    def destroy
      delete("albums/#{id}.json")
    end

  end
end