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

  private

  def encode_credentials(username, password)
    Base64.strict_encode64("#{username}:#{password}")
  end
end
