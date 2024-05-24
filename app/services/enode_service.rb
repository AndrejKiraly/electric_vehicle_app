require 'net/http'
require 'json'

class EnodeService
  TOKEN_URL = 'https://oauth.sandbox.enode.io/oauth2/token'
  VEHICLE_STATUS_URL = 'https://enode-api.sandbox.enode.io/vehicles'

  def initialize
    @client_id = ENV['ENODE_CLIENT_ID']
    @client_secret = ENV['ENODE_CLIENT_SECRET']
    @token = fetch_token
  end

  def fetch_token
    uri = URI(TOKEN_URL)
    req = Net::HTTP::Post.new(uri)
    req.set_form_data(
      'grant_type' => 'client_credentials',
      'client_id' => @client_id,
      'client_secret' => @client_secret
    )

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

    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }

    if res.is_a?(Net::HTTPSuccess)
      JSON.parse(res.body)
    else
      Rails.logger.error("EnodeService: Failed to fetch vehicle status - #{res.body}")
      nil
    end
  end
end