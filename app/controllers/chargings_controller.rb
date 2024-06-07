

class ChargingsController < ApplicationController
    before_action :authenticate_user!, except: [:show_station_with_chargings, :show_station_from_charging, :show_all, :index, :show]
    
    def show_station_with_chargings
        @stations = EvStation.where(id: 1001)
        render json: @stations.map {|station| {station: station, connections: station.connections.map {|connection| {id: connection.id, chargings: connection.chargings.map {|charging| {id: charging.id, user_id: charging.user_id, vehicle_id: charging.vehicle_id, connection_id: charging.connection_id, battery_level_start: charging.battery_level_start, battery_level_end: charging.battery_level_end, price: charging.price, energy_used: charging.energy_used, rating: charging.rating, comment: charging.comment, start_time: charging.start_time, end_time: charging.end_time}}}}} }
    end

    def index
        #@chargings = Charging.where(user_id: current_user.id, )
        @chargings = Charging.all.where(user_id: User.find_by(uid: request.headers['uid']).id)
        @chargings = @chargings.where(is_finished: true)
        render json: @chargings    
    end

    def show_all
        @chargings = Charging.all
        render json: @chargings
    end

    def show_station_from_charging
        station = Charging.find(params[:id]).connection.ev_station
        render json: {"station_id":station.id}
    end

    def monthly_summary
        @month = params[:month].to_i  
        @year = params[:year].to_i    
        @user = current_user
        @chargingMonthlySummary = Charging.monthly_summary(@month, @year, current_user.id)
        render json: MonthChargingSummarySerializer.new(@chargingMonthlySummary).serializable_hash
    end

    def show
        if params[:id] != "monthly_summary"
            @charging = Charging.find(params[:id])
            render json: @charging, serializer: ChargingSerializer
        end
    end

    def create
        @charging = Charging.createCharging(charging_params, current_user.id, params[:longitude], params[:latitude])
        if @charging != nil
            if @charging.save
                render json: @charging, status: :created
            else
                render json: @charging.errors, status: :unprocessable_entity
            end
        else
            render json: { error: "Invalid charging object" }, status: :unprocessable_entity
        end
    end

    def update
        @charging = Charging.find(params[:id])
        latitude = params[:latitude]
        longitude = params[:longitude]
        if params[:connection_id].present? && Connection.find_by(id: params[:connection_id]).nil?
            render json: { error: "Connection not found" }, status: :unprocessable_entity
            return
        end
        if @charging.update(charging_params)
            @charging.coordinates = RGeo::Geographic.spherical_factory(srid: 4326).point(longitude, latitude)
            render json: @charging
        else
            render json: @charging.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @charging = Charging.find(params[:id])
        if @charging.destroy
            head(:no_content)
        else
            head(:unprocessable_entity)
        end
    end


    private 
    def charging_params
        params.require(:charging).permit(:vehicle_id, :connection_id, :battery_level_start,
         :battery_level_end, :price, :energy_used,
          :rating, :comment, :start_time, :end_time,
           :is_finished)

    end

end
