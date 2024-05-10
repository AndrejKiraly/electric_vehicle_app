class ChargingsController < ApplicationController
    before_action :authenticate_user!


    #show all chargings for user
    def index
       @chargings = Charging.where(user_id: current_user.id)
       render json: @chargings
    end

    def show
        @charging = Charging.find(params[:id])
    end

    def create
        @charging = Charging.new(
            user_id: current_user.id,
            vehicle_id: params[:vehicle_id],
            ev_station_id: params[:ev_station_id],
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
        params.require(:charging).permit(:user_id, :vehicle_id, :ev_station_id, :battery_level_start, :battery_level_end, :price, :energy_used, :rating, :comment, :start_time, :end_time)
    end

end
