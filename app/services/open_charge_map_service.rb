class OpenChargeMapService
    def self.fetch_stations_data(countrycode)
        apikey= ENV['openChargeMapApiKey']
        request_url_openChargeMap= "https://api.openchargemap.io/v3/poi?key=#{apikey}&maxresults=10000&countrycode=#{countrycode}"
        response = RestClient.get(request_url_openChargeMap)
        if response.code == 200
            stations_data = JSON.parse(response.body)
            Rails.logger.debug("request_url_openChargeMap #{stations_data.count}")
            return stations_data
        else
            # Handle error case
            return nil
        end

    end

    def self.deserialize_station(station_data, current_user_id, country_id, uuid)
        if station_data["AddressInfo"].present?
            name = station_data["AddressInfo"]["Title"]
            latitude = station_data["AddressInfo"]["Latitude"]
            longitude = station_data["AddressInfo"]["Longitude"]
            address_line = station_data["AddressInfo"]["AddressLine1"]
            city = station_data["AddressInfo"]["Town"]
            country = station_data["AddressInfo"]["Country"]["Title"]
            post_code = station_data["AddressInfo"]["Postcode"]
            phone_number = station_data["AddressInfo"]["ContactTelephone1"] || "unknown"
            email = station_data["AddressInfo"]["ContactEmail"] || "unknown"
            coordinates = RGeo::Geographic.spherical_factory(srid: 4326).point(longitude, latitude)
          end
          
          if station_data["DataProvider"].present?
            source_id = 1
          end      
          if station_data["UsageType"].present?
            usage_type_id = station_data["UsageType"]["ID"]
          else
            usage_type_id = 0
          end
          limit_time = "Unknown"
          instruction_for_user = "Unknown"
          if station_data["OperatorInfo"].present?
            operator_website_url = station_data["OperatorInfo"]["WebsiteURL"] || "unknown"
          end
          created_by_id = current_user_id 
            
            @ev_station = EvStation.new(
              name: name,
              address_line: address_line ? address_line : "",
              city: city ? city : "",
              country_string: country ? country : "",
              post_code: post_code ? post_code : "",
              uuid: uuid,
              source_id: source_id,
              created_by_id: created_by_id,
              updated_by_id: created_by_id,
              rating: 0.0,
              user_rating_total: 0,
              phone_number: phone_number ? phone_number : "",
              email: email ? email : "",
              usage_type_id: usage_type_id ? usage_type_id : 0,
              operator_website_url: operator_website_url ? operator_website_url : "",
              instruction_for_user: instruction_for_user ,
              coordinates: coordinates,
              country_id: country_id
              
            )
            return @ev_station
    end


    def self.add_connections(station_data, ev_station, current_user_id)
        if  station_data["Connections"].present?
            connections_data = station_data["Connections"]
            connections_data.each_with_index do |connection_data, index|
                begin
                if connection_data["ConnectionType"].present?
                    connection_type_id = connection_data["ConnectionType"]["ID"]
                else
                    connection_type_id = 0
                end
                if connection_data["StatusType"].present?
                    is_operational_status = connection_data["StatusType"]["IsOperational"]
                else
                    is_operational_status = false
                end
                if connection_data["Level"].present?
                    is_fast_charge_capable = connection_data["Level"]["IsFastChargeCapable"]
                else
                    is_fast_charge_capable = false
                end

                if connection_data["CurrentType"].present?
                    current_type_id = connection_data["CurrentType"]["ID"]
                end
                if connection_data["Amps"].present?
                    amps = connection_data["Amps"]
                end
                if connection_data["Voltage"].present?
                    voltage = connection_data["Voltage"]
                end
                if connection_data["PowerKW"].present?
                    power_kw = connection_data["PowerKW"]
                end
                if connection_data["Quantity"].present?
                    quantity = connection_data["Quantity"].to_i
                end
                # Create a new Connection object for each connection
                debugger
                connection = Connection.new(
                    connection_type_id: connection_type_id ? connection_type_id : 0,
                    is_operational_status: is_operational_status ,
                    is_fast_charge_capable: is_fast_charge_capable ,
                    current_type_id: current_type_id ? current_type_id : 10,
                    amps: amps ? amps : 0,
                    voltage: voltage ? voltage : 0,
                    power_kw: power_kw ? power_kw : 0,
                    quantity: quantity ? quantity : 0,
                    created_by_id: current_user_id,
                    updated_by_id: current_user_id
                )               
                
                connection.ev_station = ev_station
                connection.save
                rescue => e
                return "Error creating connection: #{e.message}, ev_station: #{ev_station}"
                end
            end
        end
        return "success"
    end

end



        