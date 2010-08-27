require 'cgi'
module Grin

  class Client

    API_VERSION = "v1"
    DOMAIN = "fotogger.com"

    def initialize(subdomain, email, password)
      @@auth_string = CGI.escape(email) + ':' + CGI.escape(password) + "@" + subdomain
    end

    def albums
      albums = []
      get('albums.json').each { |album| albums << Album.new(album) }
      return albums
    end

    def album(id)
      if album = get("albums/#{id}.json")
        Album.new(album)
      end
    end

    def create_album(title, category_id = categories.first.id)
      if album = post("albums.json", { :album => { :title => title, :category_id => category_id } })
        return Album.new(album)
      end
    end

    def find_or_create_album(title, category_id)
      if album = albums.select { |a| a.title == title }.pop
        return album
      else
        create_album(title, category_id)
      end
    end

    def categories
      categories = []
      get('categories.json').each { |category| categories << Category.new(category) }
      return categories
    end

    def category(id)
      if category = get("categories/#{id}.json")
        Category.new(category)
      end
    end

    def create_category(name)
      if category = post("categories.json", { :category => { :name => name } })
        return Category.new(category)
      end
    end

    def find_or_create_category(name)
      if category = categories.select { |c| c.name == name }.pop
        return category
      else
        create_category(name)
      end
    end

    private

    def get(path)
      JSON.parse(RestClient.get("http://#{@@auth_string}.#{DOMAIN}/api/#{API_VERSION}/#{path}"))
    end

    def post(path, params = {})
      JSON.parse(RestClient.post("http://#{@@auth_string}.#{DOMAIN}/api/#{API_VERSION}/#{path}", params))
    end

    def delete(path)
      JSON.parse(RestClient.delete("http://#{@@auth_string}.#{DOMAIN}/api/#{API_VERSION}/#{path}"))
    end

  end
end