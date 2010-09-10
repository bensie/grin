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
      album = get("albums/#{id}.json")
      if album.respond_to?(:[]) && album['result'] == 'failure'
        return album
      else
        Album.new(album)
      end
    end

    def create_album(title, category_id = categories.first.id)
      album = post("albums.json", { :album => { :title => title, :category_id => category_id } })
      if album.respond_to?(:[]) && album['result'] == 'failure'
        return album
      else
        Album.new(album)
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
      category = get("categories/#{id}.json")
      if category.respond_to?(:[]) && category['result'] == 'failure'
        return category
      else
        Category.new(category)
      end
    end

    def create_category(name)
      category = post("categories.json", { :category => { :name => name } })
      if category.respond_to?(:[]) && category['result'] == 'failure'
        return category
      else
        Category.new(category)
      end
    end

    def find_or_create_category(name)
      category = categories.select { |c| c.name == name }.pop
      if category
        return category
      else
        create_category(name)
      end
    end

    private

    def get(path)
      JSON.parse(RestClient.get(url(path)))
    end

    def post(path, params = {})
      JSON.parse(RestClient.post(url(path), params))
    end

    def delete(path)
      JSON.parse(RestClient.delete(url(path)))
    end

    def url(path)
      "http://#{@@auth_string}.#{DOMAIN}/api/#{API_VERSION}/#{path}"
    end

  end
end