class EvStationsController < ApplicationController

  before_action :set_ev_station, only: %i[ show update destroy ]
  before_action :authenticate_user!, except: [:index, :show, :show_stations_close_to_charging, :show_chargings_for_station, :show_connections_for_station]

  # GET /ev_stations
  def show_user_stations
    page = params[:page].to_i || 1 
    @stations = current_user.ev_stations
    @stations = @stations.offset((page) * 50).limit(50)
    render json: @stations, each_serializer: EvStationSerializer
  end

  def index
    ev_stations = EvStation.filter_stations(params)
    factory = RGeo::Geographic.spherical_factory(srid: 4326)
    ev_stations.each do |station|
      point = factory.point(params[:lng], params[:lat])
      station.distance = station.coordinates.distance(point) / 1000
    end
    render json: ev_stations, each_serializer: CompactEvStationSerializer
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

  # POST /ev_stations
  def create
      @ev_station = EvStation.createStation(ev_station_creating_params, current_user.id)
      if @ev_station.save
        render json: @ev_station, status: :created
      else
        render json: @ev_station.errors, status: :unprocessable_entity
      end

  end
  
  def create_multiple
    if current_user.is_admin == false
      render json: { message: "You are not authorized to create stations" }, status: :unauthorized
    end
    if Country.find_by(iso_code: params[:countrycode].upcase).nil?
      render json: { message: "Country not found" }, status: :not_found
    else
      response = EvStation.generate_stations_from_open_charge_maps(params[:countrycode], current_user.id)
      if response.is_a?(Integer)
        render json: { message: "Stations created successfully. Added #{response} number of Stations" }, status: :created
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
    
  end
    
  # PATCH/PUT /ev_stations/1
  def update
    if @ev_station.update(ev_station_creating_params)
      @ev_station.updated_by_id = current_user.id
      latitude = params[:latitude]
      longitude = params[:longitude]
      @ev_station.coordinates = RGeo::Geographic.spherical_factory(srid: 4326).point(longitude, latitude)
      render json: @ev_station, each_serializer: EvStationSerializer
    else
      render json: @ev_station.errors, status: :unprocessable_entity
    end
  end

  # DELETE /ev_stations/1
  def destroy
    @ev_station.destroy!
    render json: {message: "Deleted Succesfully"},status: :no_content
  end

  def destroy_multiple
    if params[:country_string].present?
      @ev_stations = EvStation.where(country_string: params[:country])
    else
      @ev_stations = EvStation.all
    end
    if @ev_stations.destroy_all
      render json: { message: "Stations deleted successfully" }, status: :no_content
    else
      render json: { message: "Failed to delete stations" }, status: :unprocessable_entity
    end
  end

  private
    def set_ev_station
      @ev_station = EvStation.find(params[:id])
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