require 'net/http'
require 'json'
require "fast_polylines"

class MapboxService
    MAPBOX_API_URL = "https://api.mapbox.com/matching/v5/mapbox/driving?access_token="

    def initialize()
        @access_token = ENV['MAPBOX_ACCESS_TOKEN']
    end

    def map_matching(points)
        
        uri = URI("#{MAPBOX_API_URL}")
          
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        request = Net::HTTP::Post.new(uri.path+"?access_token="+@access_token)
        request["Content-Type"] = "application/x-www-form-urlencoded"
        
        request.body = URI.encode_www_form({
            coordinates:  points.gsub(/\[|\]/, '')
        })

            # Add other query parameters as needed (e.g., radiuses, steps)
        
        
        response = http.request(request)
        body = JSON.parse(response.body)
        debugger
        decoded_coordinates = FastPolylines.decode(body["matchings"][0]["geometry"])
        

        
        
    end

    
end