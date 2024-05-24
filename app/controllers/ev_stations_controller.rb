class EvStationsController < ApplicationController

    #include InvoiceCreator
  before_action :set_ev_station, only: %i[ show update destroy ]
  #before_action :authenticate_user!, except: [:index, :show, :show_polyline]
  before_action :set_user, only: %i[ show_user_stations create_multiple create update destroy]

  # GET /ev_stations
  def show_user_stations
    if @user.nil?
      render json: { error: "User not found" }
    end
    @stations = EvStation.where(created_by_id: @user.id)
    render json: @stations

  end

  def index
    latitude = params[:lat].to_f
    longitude = params[:lng].to_f
    bounds_sw_lat = params[:bounds_sw].split(",")[0].to_f
    bounds_sw_lng = params[:bounds_sw].split(",")[1].to_f
    bounds_ne_lat = params[:bounds_ne].split(",")[0].to_f
    bounds_ne_lng = params[:bounds_ne].split(",")[1].to_f
    Rails.logger.info("Bounds: #{bounds_sw_lat}, #{bounds_sw_lng}, #{bounds_ne_lat}, #{bounds_ne_lng}")

    

    #InvoiceCreator::TAX_FEE
    #InvoiceCreator.generate
    #isa_access_key_required = params[:isAccessKeyRequired]
    #is_membership_required = params[:isMembershipRequired]
    #is_pay_at_location = params[:isPayAtLocation]
    #is_fast_charge_capable = params[:isFastChargeCapable]
    #charging_level = params[:charging_level]
    
    
    searching_distance = params[:distance].to_i  # Distance in kilometers
    ev_stations = EvStationService.new(params).call
    #ev_stations_with_param = EvStation.filter_by_params_dynamic(params)

    #diagonal = (sin((bounds_ne_lat * pi / 180) / 2) * sin((bounds_ne_lat * pi / 180) / 2) + cos(bounds_ne_lat * pi / 180) * cos(bounds_ne_lat * pi / 180) * sin((bounds_ne_lng * pi / 180) / 2) * sin((bounds_ne_lng * pi / 180) / 2))

    
    #ev_stations = EvStation.all.near(latitude, longitude, area)
    # ev_stations = EvStation.all.where("latitude >= ? AND latitude <= ? AND longitude >= ? AND longitude <= ?", bounds_sw_lat, bounds_ne_lat, bounds_sw_lng, bounds_ne_lng)
    # ev_stations = ev_stations.where(is_free: params[:is_free]) if params[:is_free].present?
    # ev_stations = ev_stations.where(usage_type_id: params[:usage_type_id]) if params[:usage_type_id].present?
    # ev_stations = ev_stations.includes(:connections).where(connections: {is_fast_charge_capable: params[:is_fast_charge_capable]}) if params[:is_fast_charge_capable].present?
    # ev_stations = ev_stations.includes(:connections).where(connections: {current_type_id: params[:current_type_id]}) if params[:current_type_id].present?
    # ev_stations = ev_stations.includes(:connections).where(connections: {connection_type_id: params[:connection_type_id]}) if params[:connection_type_id].present?
    
    # ev_stations = ev_stations.includes(:connections).where(connections: {current_type_id: params[:current_type_id]}) if params[:current_type_id].present?
    # ev_stations = ev_stations.where(
    #   id: Connection.select(:ev_station_id)
    #                 .where("power_kw > ?", params[:power_kw]))if params[:power_kw].present?

                    
    # #amenity_ids_dam_do_int = params[:amenity_ids].map(&:to_i)
    # if params[:amenity_ids].present?
    #   amenity_ids = params[:amenity_ids].split(',').map(&:to_i)  # Ensure amenity_ids is an array of integers
    #   ev_stations = ev_stations.joins(:amenities).where(amenities: { id: amenity_ids }).distinct
    # end

    # if params[:usage_type_ids].present?
    #   usage_type_ids = params[:usage_type_ids].split(',').map(&:to_i)  # Ensure amenity_ids is an array of integers
    #   ev_stations = ev_stations.where(usage_type_id: usage_type_ids)
    # end

    # if params[:connection_type_ids].present?
    #   connection_type_ids = params[:connection_type_ids].split(',').map(&:to_i)  # Ensure amenity_ids is an array of integers
    #   ev_stations = ev_stations.joins(:connections).where(connections: { connection_type_id: connection_type_ids }).distinct
    # end
    
    # ev_stations = ev_stations.where("rating >= ?", params[:rating]) if params[:rating].present?
    # ev_stations = ev_stations.includes(:connections).where(connections: {connection_type_id: params[:connection_type_id]}) if params[:connection_type_id].present?
    #ev_stations_with_param = ev_stations_with_param.near(latitude, longitude, searching_distance) 
    
    
    render json: ev_stations, each_serializer: CompactEvStationSerializerSerializer
  

  end

  # GET /ev_stations/1
  def show
    render json: @ev_station
  end

  def show_chargings_for_station
    #Charging.find(1).connection.ev_station.id
    @station = EvStation.find(params[:id])
    @chargings = @station.chargings

    render json:  @chargings
    
    #{station: @station, connections: @station.connections.map {|connection| {id: connection.id, chargings: connection.chargings.map {|charging| {id: charging.id, user_id: charging.user_id, vehicle_id: charging.vehicle_id, connection_id: charging.connection_id, battery_level_start: charging.battery_level_start, battery_level_end: charging.battery_level_end, price: charging.price, energy_used: charging.energy_used, rating: charging.rating, comment: charging.comment, start_time: charging.start_time, end_time: charging.end_time}}}}}

  end

  def show_connections_for_station
    @station = EvStation.find(params[:id])
    @connections = @station.connections

    render json: @connections
  end

  def show_stations_close_to_charging
    @charging = Charging.find(params[:id])
    
    if @charging.latitude == nil || @charging.longitude == nil
      render json: { error: "Charging has no latitude or longitude" }, status: :unprocessable_entity
    
    else
      @stations = EvStation.near(@charging.latitude, @charging.longitude, 10)
      render json: @stations, each_serializer: EvStationSerializer
    end
    
  end

  def show_polyline
    if (request.params[:polyline].present? && request.params[:distance].present? )
      polyline = request.params[:polyline]
      searching_distance = params[:distance].to_i
      decoded_polyline = FastPolylines::Decoder.decode(polyline)
      latitude= decoded_polyline[0][0]
      longitude = decoded_polyline[0][1]
      unique_stations = Set.new

      decoded_polyline.each do |point|
        latitude = point[0]
        longitude = point[1]
        nearby_stations = EvStation.near(latitude, longitude, searching_distance)

        unique_stations.merge(nearby_stations)
      end


      
      
      
      render json: unique_stations.map { |station| station.as_json(include_distance: true, distance: station.distance(latitude, longitude)) }
    else
      render json: { error: "Invalid parameters" }
      
    end


  end

  # POST /ev_stations
  def create    
    # Single station creation logic 
    station_data = JSON.parse(request.body.read)
      # Check if the station is unique using the class method
      if EvStation.is_unique(station_data["ev_station"])
        # Station is unique, proceed with creating the record
        @ev_station = EvStation.new(
          ev_station_creating_params
        )
        @ev_station.created_by_id = User.where(uid: request.headers["uid"]).first.id
        @ev_station.updated_by_id = User.where(uid: request.headers["uid"]).first.id
        @ev_station.amenity_ids = params[:amenity_ids]
        @ev_station.country_id = 1
        if @ev_station.save
          render json: @ev_station, status: :created
        else
          logger.error "EV Station creation failed: #{@ev_station.errors.full_messages}"
          render json: @ev_station.errors,  status: :unprocessable_entity
        end
      else
        # Station already exists, return an error message
        render json: { message: " Station already exists" }, status: :unprocessable_entity
      end
  end


    def create_multiple
      if (request.headers['multipleStations'].present? && request.headers['latitude'].present? && request.headers['longitude'].present?)
        Dotenv.load('.env')
        apikey= ENV['openChargeMapApiKey']
        latitude = request.headers['latitude'] 
        longitude = request.headers['longitude']
        countrycode = params[:countrycode]
        request_url_openChargeMap= "https://api.openchargemap.io/v3/poi?key=#{apikey}&maxresults=1000&countrycode=#{countrycode}"
        response = RestClient.get(request_url_openChargeMap)
        if response.code == 200
          stations_data = JSON.parse(response.body)
        else
          # Handle error case
          render json: { error: "Failed to fetch data from open chargemap api" }, status: :not_found
        end
        stations = []
    
        stations_data.each do |station_data|
          puts station_data.length
          if EvStation.is_unique(station_data) && station_data.present?
            puts"creating new station"
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
            end
            uuid = station_data["UUID"]
            if station_data["DataProvider"].present?
              source = station_data["DataProvider"]["Title"]
            end
            created_by_id = 1
            updated_by_id = 1            
            
            if station_data["UsageType"].present?
              usage_type_id = station_data["UsageType"]["ID"]
            else
              usage_type_id = 0
            end
            
            limit_time = "Unknown"
            instruction_for_user = "Unknown"
            energy_source = "Unknown"
            

            if station_data["OperatorInfo"].present?
              operator_website_url = station_data["OperatorInfo"]["WebsiteURL"] || "unknown"
            end
           


            # Create a new station object with the extracted data
            @ev_station = EvStation.new(
              name: name,
              latitude: latitude,
              longitude: longitude,
              address_line: address_line ? address_line : "",
              city: city ? city : "",
              country_string: country ? country : "",
              post_code: post_code ? post_code : "",
              uuid: uuid,
              source: source ? source : "",
              created_by_id: created_by_id,
              updated_by_id: updated_by_id,
              rating: 0.0,
              user_rating_total: 0,
              phone_number: phone_number ? phone_number : "",
              email: email ? email : "",
              usage_type_id: usage_type_id ? usage_type_id : 0,
              operator_website_url: operator_website_url ? operator_website_url : "",
              limit_time: limit_time ? limit_time : "",
              instruction_for_user: instruction_for_user ? instruction_for_user : "",
              energy_source: energy_source ? energy_source : "",
              
              

              
            )           
            if @ev_station.save
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
                  end
                  if connection_data["Level"].present?
                    is_fast_charge_capable = connection_data["Level"]["IsFastChargeCapable"]
                    charging_level = connection_data["Level"]["Title"] 
                    charging_level_comment = connection_data["Level"]["Comments"] 
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
                  created_by_id = 1
                  updated_by_id = 1
          
                  # Create a new Connection object for each connection
                  connection = Connection.new(
                    connection_type_id: connection_type_id ? connection_type_id : 0,
                    is_operational_status: is_operational_status ? is_operational_status : false,
                    is_fast_charge_capable: is_fast_charge_capable ? is_fast_charge_capable : false,
                    charging_level: charging_level ? charging_level : "unknown",
                    #charging_level_comment: charging_level_comment ? charging_level_comment : "unknown",
                    current_type_id: current_type_id ,
                    amps: amps ? amps : 0,
                    voltage: voltage ? voltage : 0,
                    power_kw: power_kw ? power_kw : 0,
                    quantity: quantity ? quantity : 0,
                    created_by_id: created_by_id,
                    updated_by_id: updated_by_id

                  )
          
                  # Associate the connection with the station
                  
                  connection.ev_station = @ev_station
          
                  # Save the connection
                  connection.save
                rescue => e
                  puts "Error processing connection data: #{e.message}"
                end
              end
            end
              stations << @ev_station
            end
          else
            # Skip saving non-unique stations
            next
          end
        end
    
        if stations.any?
          render json: stations, status: :created
        else
          render json: { message: "No stations were created" }, status: :unprocessable_entity
        end
      else
        render json: {message: request.headers['multipleStations']}
      end
    end
  

  

  # PATCH/PUT /ev_stations/1
  
  def update
    if @ev_station.update(ev_station_creating_params)
      #@ev_station.update(amenity_ids: [1,2,3])
      
      @ev_station.updated_by_id = User.where(uid: request.headers["uid"]).first.id
      @ev_station.amenity_ids = params[:amenity_ids]
      Rails.logger.info("Params before processing: #{params.inspect}") # Log all parameters

      Rails.logger.info("Amenity ids: #{ev_station_creating_params[:amenity_ids]}")

      render json: {station: @ev_station, amenities: @ev_station.amenities}
    else
      render json: @ev_station.errors, status: :unprocessable_entity
    end
  end

  # DELETE /ev_stations/1
  def destroy
    @ev_station.destroy!
  end

  def destroy_multiple
    if params[:country_string].present?
      @ev_stations = EvStation.where(country_string: params[:country])
    else
      @ev_stations = EvStation.all
    end
    if @ev_stations.destroy_all
      render json: { message: "Stations deleted successfully" }
    else
      render json: { message: "Failed to delete stations" }
    end

    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ev_station
      @ev_station = EvStation.find(params[:id])
    end

    def set_user
      @user = User.find_by(uid: request.headers["uid"])
      
    end

    # Only allow a list of trusted parameters through.
    def ev_station_params
      params.require(:ev_station).permit(:name, :latitude, :longitude,
       :address_line, :city, :country_string,
        :post_code, :uuid, :source, :created_by_id,
        :updated_by_id, :rating, :user_rating_total,
         :phone_number, :email, :operator_website_url,
         :is_free,:open_hours,:usage_type_id,:usage_type_ids[],
          :amenity_ids,
          :current_type_id,
           :connection_type_id,
           :connection_types_id[], :country_id )
    end

    def ev_station_creating_params
      params.require(:ev_station).permit(
        :name,
        :latitude,
        :longitude,
        :address_line, :city, :country_string, :post_code,
        :uuid, :source, :created_by_id,:updated_by_id,
        :rating, :user_rating_total, :phone_number, :email,
        :operator_website_url,:is_free,:open_hours, :usage_type_id, 
        :country_id,amenity_ids: []
        )
      
    end


end
