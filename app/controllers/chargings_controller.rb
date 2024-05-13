

class ChargingsController < ApplicationController
    
    #before_action :authenticate_user!
    
    



    def show_station_with_chargings
        @stations = EvStation.where(id: 1001)

        render json: @stations.map {|station| {station: station, connections: station.connections.map {|connection| {id: connection.id, chargings: connection.chargings.map {|charging| {id: charging.id, user_id: charging.user_id, vehicle_id: charging.vehicle_id, connection_id: charging.connection_id, battery_level_start: charging.battery_level_start, battery_level_end: charging.battery_level_end, price: charging.price, energy_used: charging.energy_used, rating: charging.rating, comment: charging.comment, start_time: charging.start_time, end_time: charging.end_time}}}}} }

    end

    def show_chargings_for_station
        #ev_station_id = Charging.find(1).connection.ev_station.id
        #Rails.logger.debug("ev_station_id: #{ev_station_id}")
    end
    #show all chargings for user
    def index
        #@chargings = Charging.where(user_id: current_user.id, )
        @chargings = Charging.all.where(id: 1)
        
         
        #Rails.logger.debug("charging_time: #{ChargingLibrary.calculateChargingTime(100, 16, 60, 100, 16)} ")

        

        
        
        render json: {charging: @chargings, charging_time: @chargings.calculate_charging_time("9cefa962-c2f4-4b43-b636-6632c5cdedc5",1, 50)}
    
    

    end

    def show
        @charging = Charging.find(params[:id])
    end

    def create
        @charging = Charging.new(
            user_id: current_user.id,
            vehicle_id: params[:vehicle_id],
            connection_id: params[:connection_id],
            battery_level_start: params[:battery_level_start],
            battery_level_end: params[:battery_level_end],
            price: params[:price],
            energy_used: params[:energy_used],
            rating: params[:rating],
            comment: params[:comment],
            start_time: params[:start_time],
            end_time: params[:end_time]
            
        )
        if @charging.save
            render json: @charging, status: :created
        else
            render json: @charging.errors, status: :unprocessable_entity
        end
    end

    def update
        @charging = Charging.find(params[:id])
        if @charging.update(charging_params)
            render json: @charging
        else
            render json: @charging.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @charging = Charging.find(params[:id])
        if @charging.destroy
            render json: { message: 'Charging deleted successfully' }, status: :ok
        else
            render json: @charging.errors, status: :unprocessable_entity
        end
    end


    private 
    def charging_params
        params.require(:charging).permit(:user_id, :vehicle_id, :connection_id, :battery_level_start, :battery_level_end, :price, :energy_used, :rating, :comment, :start_time, :end_time)
    end

end
