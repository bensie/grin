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
    
    private
  
    def get(path, ssl = false)
      JSON.parse(RestClient.get("http://#{@auth_string}.fotogger.com/api/#{API_VERSION}/#{path}").body)
    end
    
  end
end