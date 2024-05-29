class EvStationsController < ApplicationController

    #include InvoiceCreator
  before_action :set_ev_station, only: %i[ show update destroy ]
  #before_action :authenticate_user!, except: [:index, :show, :create_multiple, :show_polyline]
  before_action :set_user, only: %i[ show_user_stations create update destroy]
  require "fast_polylines"

  # GET /ev_stations
  def show_user_stations
    
    @stations = User.where(id: 1).first.ev_stations.first
    render json: @stations

  end

  def index
    #ev_stations = EvStationService.new(params).call
    #ev_stations_with_param = EvStation.filter_by_params_dynamic(params)
    #InvoiceCreator::TAX_FEE
    #InvoiceCreator.generate
    latitude = params[:lat].to_f
    longitude = params[:lng].to_f
    ev_stations = EvStation.filter_stations(params)
    render json: ev_stations, each_serializer: CompactEvStationSerializerSerializer
  end

  # GET /ev_stations/1
  def show
    render json: @ev_station, each_serializer: EvStationSerializer
  end

  def show_chargings_for_station
    @station = EvStation.find(params[:id])
    @chargings = @station.chargings
    render json: @chargings, each_serializer: ChargingSerializer
  end

  def show_connections_for_station
    @station = EvStation.find(params[:id])
    @connections = @station.connections
    render json: @connections
  end

  def show_stations_close_to_charging
    @charging = Charging.find(params[:id])
    if @charging.coordinates.x == nil || @charging.coordinates.y == nil
      render json: { error: "Charging has no latitude or longitude" }, status: :unprocessable_entity
    else
      @stations = EvStation.within_distance(@charging.coordinates.x,@charging.coordinates.y, 10000)
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


      
      
      
      render json: unique_stations , each_with_index: CompactEvStationSerializerSerializer
    else
      render json: { error: "Invalid parameters" }
      
    end


  end

  # POST /ev_stations
  def create
      @ev_station = EvStation.createStation(ev_station_creating_params, 1)
      if @ev_station.save
        render json: @ev_station, status: :created
      else
        render json: @ev_station.errors, status: :unprocessable_entity
      end

  end


    def create_multiple
        response = EvStation.generateStationsFromOpenChargeMaps(params[:countrycode], 1)
        if response.is_a?(Integer)
          render json: { message: "Stations created successfully. Added #{reponse} number of Stations" }, status: :created
        elsif response.is_a?(String) && response.include?("All stations were already created")
          render json: { message: response }, status: :created
        elsif response.is_a?(String) && response.include?("Error creating connection:")
          render json: { message: response }, status: :unprocessable_entity
        elsif response.is_a?(String) && response.include?("Could not fetch data from OpenChargeMap API")
          render json: { message: response }, status: :unprocessable_entity
        else
          render json: { message: "Unkown error" }, status: :unprocessable_entity
        end
    end
  

  

  # PATCH/PUT /ev_stations/1
  
  def update
    if @ev_station.update(ev_station_creating_params)
      #@ev_station.update(amenity_ids: [1,2,3])
      
      @ev_station.updated_by_id = current_user.id
      @ev_station.amenity_ids = params[:amenity_ids]
      latitude = params[:latitude]
      longitude = params[:longitude]
      @ev_station.coordinates = RGeo::Geographic.spherical_factory(srid: 4326).point(longitude, latitude)
      
      Rails.logger.info("Amenity ids: #{ev_station_creating_params[:amenity_ids]}")

      render json: @ev_station, each_serializer: EvStationSerializer
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
          :current_type_id,:country_id, :source_id,
           :connection_type_id,
           :connection_types_id[]  )
    end

    def ev_station_creating_params
      params.require(:ev_station).permit(
        :name, :latitude, :longitude,
        :address_line, :city, :country_string, :post_code,
        :uuid, :source, :created_by_id,:updated_by_id,
        :rating, :user_rating_total, :phone_number, :email,
        :operator_website_url,:is_free,:open_hours, :usage_type_id, :source_id, 
        :country_id,amenity_ids: [],connection_types_ids:[] )
      
    end


end
