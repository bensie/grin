module Grin

  class Client
  
    API_VERSION = "v1"
     
    def initialize(subdomain, email, password)
      @auth_string = CGI.escape(email) + ':' + CGI.escape(password) + "@" + subdomain
    end
    
    def albums
      albums = []
      get('albums.json').each { |album| albums << Album.new(album, @auth_string) }
      return albums
    end
    
    def album(id)
      if album = get("albums/#{id}.json")
        Album.new(album, @auth_string)
      end
    end
    
    def create_album(title, category_id = nil)
      if album = post("albums.json", { :album => { :title => title, :category_id => category_id } })
        return Album.new(album, @auth_string)
      end
    end
    
    def find_or_create_album(title, category_id = nil)
      if album = albums.select { |a| a.title == title }.pop
        return album
      else
        create_album(title, category_id)
      end
    end
    
    private
  
    def get(path)
      JSON.parse(RestClient.get("http://#{@auth_string}.fotogger.com/api/#{API_VERSION}/#{path}").body)
    end
    
    def post(path, params = {})
      JSON.parse(RestClient.post("http://#{@auth_string}.fotogger.com/api/#{API_VERSION}/#{path}", params).body)
    end
    
  end
end