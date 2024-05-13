module EnodeModule


    def self.enode_login
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

    def self.get_enode_vehicle(access_token, id)
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
end