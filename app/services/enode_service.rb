require 'net/http'
require 'json'
require 'base64'

class EnodeService
  TOKEN_URL = 'https://oauth.sandbox.enode.io/oauth2/token'
  VEHICLE_STATUS_URL = 'https://enode-api.sandbox.enode.io/vehicles'

  def initialize
    @username = ENV['ENODE_CLIENT_ID']
    @password = ENV['ENODE_CLIENT_SECRET']
    @token = fetch_token
  end

  def fetch_token
    uri = URI(TOKEN_URL)
    req = Net::HTTP::Post.new(uri)
    req['Content-Type'] = 'application/x-www-form-urlencoded'
    req['Authorization'] = "Basic #{encode_credentials(@username, @password)}"
    req.set_form_data('grant_type' => 'client_credentials')

    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }


    if res.is_a?(Net::HTTPSuccess)
      JSON.parse(res.body)['access_token']
    else
      Rails.logger.error("EnodeService: Failed to fetch token - #{res.body}")
      nil
    end
  end

  def vehicle_status(vehicle_id)
    return unless @token

    uri = URI("#{VEHICLE_STATUS_URL}/#{vehicle_id}")
    req = Net::HTTP::Get.new(uri)
    req['Authorization'] = "Bearer #{@token}"
    req['Content-Type'] = 'application/json'

    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }

    if res.is_a?(Net::HTTPSuccess)
      JSON.parse(res.body)
    else
      Rails.logger.error("EnodeService: Failed to fetch vehicle status - #{res.body}")
      nil
    end
  end

  def unlink_user(user_id)
    return unless @token

    url = "https://enode-api.sandbox.enode.io/users/#{user_id}"
    headers = { 'Authorization': "Bearer #{@token}",
                'Content-Type': 'application/json' }
    begin
      # Execute DELETE request
      response = RestClient::Request.execute(
        method: :delete,
        url: url,
        headers: headers
      )
    
      # Check response code
      if response.code != 200 && response.code != 204
        puts "Error: #{response.code}, #{JSON.parse(response.code)['error']}, #{JSON.parse(response.code)['error_description']}"
        return nil
      end
    
      # Handle successful deletion (200 OK or 204 No Content)
      return response.body.empty? ? nil : JSON.parse(response.body)  # Handle empty or non-empty response body
    
    rescue RestClient::ExceptionWithResponse => e
      puts "Error: #{e.response}"
      return nil
    end
  end

  def get_enode_vehicles()
    return unless @token
    url = "https://enode-api.sandbox.enode.io/vehicles"
    headers = { 'Authorization': "Bearer #{@token}",
                'Content-Type': 'application/json' }
    begin
        response = RestClient::Request.execute(
            method: :get,
            url: url,
            headers: headers,
            )
        if response.code != 200
            puts "Error: #{response.code}, #{JSON.parse(response.body)['error']}, #{JSON.parse(response.body)['error_description']}"
            return nil
        end
        return JSON.parse(response.body)
    rescue RestClient::ExceptionWithResponse => e
        puts "Error: #{e.response}"
        return nil
    end
end

def get_enode_vehicle(id)
  return unless @token
  url = "https://enode-api.sandbox.enode.io/vehicles/#{id}"
  headers = { 'Authorization': "Bearer #{@token}",
              'Content-Type': 'application/json' }
  begin
      response = RestClient::Request.execute(
          method: :get,
          url: url,
          headers: headers,
          )
      if response.code != 200
          puts "Error: #{response.code}, #{JSON.parse(response.body)['error']}, #{JSON.parse(response.body)['error_description']}"
          return nil
      end
      return JSON.parse(response.body)
  rescue RestClient::ExceptionWithResponse => e
      puts "Error: #{e.response}"
      return nil
  end
end

  def get_enode_user_vehicles( user_id)
    return unless @token
    url = "https://enode-api.sandbox.enode.io/users/#{user_id}/vehicles"
    headers = {'Authorization': "Bearer #{@token}",
                'Content-Type': 'application/json' }
    begin
        response = RestClient::Request.execute(
            method: :get,
            url: url,
            headers: headers,
            )
        if response.code != 200
            puts "Error: #{response.code}, #{JSON.parse(response.body)['error']}, #{JSON.parse(response.body)['error_description']}"
            return nil
        end
        return JSON.parse(response.body)
    rescue RestClient::ExceptionWithResponse => e
        puts "Error: #{e.response}"
        return nil
    end
  end
  def enode_link_vehicle_to_user(user_id)
    return unless @token
    url = "https://enode-api.sandbox.enode.io/users/#{user_id}/link"
    headers = {'Authorization': "Bearer #{@token}",
                'Content-Type': 'application/json' }

    payload = {
        "vendorType": "vehicle",
        "language": "en-US",
        "scopes": [
          "vehicle:read:data",
          "vehicle:read:location",
          "vehicle:control:charging"
        ],
        "colorScheme": "system",
        "redirectUri": "yourapp://integrations/enode"
    }.to_json
    begin
        response = RestClient::Request.execute(
            method: :post,
            url: url,
            headers: headers,
            payload: payload
            
        )
        if response.code != 200
            
            puts "Error: #{response.code}, #{JSON.parse(response.body)['error']}, #{JSON.parse(response.body)['error_description']}"
            return nil
        end
        
        return JSON.parse(response.body)
    rescue RestClient::ExceptionWithResponse => e
        puts "Error: #{e.response}, #{e.response.body}"
        return nil
    end
  end



  private

  def encode_credentials(username, password)
    Base64.strict_encode64("#{username}:#{password}")
  end
end
