class EnodeVehiclesController < ApplicationController

    before_action :authenticate_user!, only: [:user_vehicles,:create, :patch, :delete]


    def index
        # Your code for the index method goes here
        enode_access_code = login_to_enode
        if enode_access_code.nil?
            render json: { message: 'Enode vehicles index failed'}
        end
        enode_vehicles = get_enode_vehicles(enode_access_code)
        data = enode_vehicles["data"]

        render json: enode_vehicles#data.map { |vehicle| { id: vehicle["id"], }}
    end

    def user_vehicles 
        enode_access_code = login_to_enode
        if enode_access_code.nil?
            render json: { message: 'Enode vehicles index failed'}
        end
        enode_user_vehicles = get_enode_user_vehicles(enode_access_code, current_user.id)
        data = enode_user_vehicles["data"]
        puts "data #{enode_user_vehicles}" 
        render json: enode_user_vehicles
    end

    def create
        enode_access_code = login_to_enode
        if enode_access_code.nil?
            render json: { message: 'Linking enode vehicle failed'}
        end
        enode_vehicle_link_url = enode_link_vehicle_to_user(enode_access_code, current_user.id)
        if enode_vehicle_link_url.nil?
            render json: { message: 'Linking enode vehicle failed'}
        end
        render json: { message: 'Vehicle link url generated', user_id: current_user.id, link: enode_vehicle_link_url ['linkUrl']}
    end

    def patch
        # Your code for the patch method goes here
    end

    def delete
        # Your code for the delete method goes here
    end

    def show
        # Your code for the show method goes here
    end

    private 

    def login_to_enode
        Dotenv.load('.env')
        client_id = ENV['ENODE_CLIENT_ID']
        client_secret = ENV['ENODE_CLIENT_SECRET']
        url = "https://oauth.sandbox.enode.io/oauth2/token"
        #client_id = Base64.encode64(client_id)
        #client_secret = Base64.encode64(client_secret)
        basic_auth = { username: client_id, password: client_secret }
        payload = { grant_type: 'client_credentials' }

        begin
            response = RestClient::Request.execute(
                method: :post,
                url: url,
                user: client_id,
                password: client_secret,
                payload: payload
            )
            if response.code != 200
                puts "Error: #{response.code}, #{JSON.parse(response.body)['error']}, #{JSON.parse(response.body)['error_description']}"
                return nil
            end
            access_token = JSON.parse(response.body)['access_token']
            puts access_token
            return access_token
        rescue RestClient::ExceptionWithResponse => e
            puts "Error: #{e.response}"
        end     
    end

    def get_enode_vehicles(access_token)
        url = "https://enode-api.sandbox.enode.io/vehicles"
        headers = { 'Authorization': "Bearer #{access_token}",
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
        end
    end

    def get_enode_vehicle(access_token, id)
        url = "https://enode-api.sandbox.enode.io/vehicles/#{id}"
        headers = { 'Authorization': "Bearer #{access_token}",
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

    def get_enode_user_vehicles(access_token, user_id)
        url = "https://enode-api.sandbox.enode.io/users/#{user_id}/vehicles"
        headers = {'Authorization': "Bearer #{access_token}",
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

    def enode_link_vehicle_to_user(access_token, user_id)
        url = "https://enode-api.sandbox.enode.io/users/#{user_id}/link"
        headers = {'Authorization': "Bearer #{access_token}",
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
end
