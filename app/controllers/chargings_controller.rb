

class ChargingsController < ApplicationController
    
    #before_action :authenticate_user!
    
    
    



    def show_station_with_chargings
        @stations = EvStation.where(id: 1001)
        render json: @stations.map {|station| {station: station, connections: station.connections.map {|connection| {id: connection.id, chargings: connection.chargings.map {|charging| {id: charging.id, user_id: charging.user_id, vehicle_id: charging.vehicle_id, connection_id: charging.connection_id, battery_level_start: charging.battery_level_start, battery_level_end: charging.battery_level_end, price: charging.price, energy_used: charging.energy_used, rating: charging.rating, comment: charging.comment, start_time: charging.start_time, end_time: charging.end_time}}}}} }
    end

    def index
        #@chargings = Charging.where(user_id: current_user.id, )
        @chargings = Charging.all.where(user_id: current_user.id)
        #Rails.logger.debug("charging_time: #{ChargingLibrary.calculateChargingTime(100, 16, 60, 100, 16)} ")
        render json: @chargings
        #render json: {charging: @chargings, charging_time: @chargings.calculate_charging_time("9cefa962-c2f4-4b43-b636-6632c5cdedc5",1, 50)}
    
    end

    def show
        @charging = Charging.find(params[:id])
        render json: @charging
    end

    def create
        current_user_id = User.find_by(uid: request.headers['uid']).id
        @charging = ChargingCreator.new(adjust_params(params.merge(user_id: current_user_id))).create

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
            head(:ok)
        else
            head(:unprocessable_entity)
        end
    end


    private 
    def charging_params
        params.require(:charging).permit(:user_id, :vehicle_id, :connection_id, :battery_level_start, :battery_level_end, :price, :energy_used, :rating, :comment, :start_time, :end_time, :is_finished, :latitude, :longitude)

    end

    def adjust_params(params)
        params[:charging] ||= params
        params.require(:charging).permit(:user_id, :vehicle_id, :connection_id, :battery_level_start, :battery_level_end, :price, :energy_used, :rating, :comment, :start_time, :end_time, :is_finished, :latitude, :longitude)

    end



end
