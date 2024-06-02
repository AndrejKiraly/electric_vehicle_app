class VehicleRoutesController < ApplicationController
    #before_action :authenticate_user!



    def show_user_routes
        @vehicle_routes = current_user.vehicle_routes
        render json: @vehicle_routes
    end

    def update_route_polyline
        @vehicle_route = VehicleRoute.find(params[:id])
        mapboxService = MapboxService.new
        map_matched_linestring = mapboxService.map_matching(params[:coordinates])
        
        if @vehicle_route.save
            render json: @vehicle_route, status: :created
        else
            render json: @vehicle_route.errors, status: :unprocessable_entity
        end
      
    end

    def create_tracked_route
        if !VehicleRoute.exists?(vehicle_id: route_params[:vehicle_id], is_finished: false)
            
            enodeService = EnodeService.new
            vehicle = enodeService.get_enode_vehicle(route_params[:vehicle_id])
            @vehicle_route = VehicleRoute.new()
            @vehicle_route.user_id = 1
            @vehicle_route.start_time = Time.current
            @vehicle_route.battery_start = 50#vehicle['chargeState']['batteryLevel']
            @vehicle_route.vehicle_id = route_params[:vehicle_id]
            if @vehicle_route.save
                render json: @vehicle_route, status: :created
            else
                render json: @vehicle_route.errors, status: :unprocessable_entity
            end
        else 
            render json: { error: "Vehicle already has a route in progress" }, status: :unprocessable_entity
        end
        
    end

    def end_tracked_route
        @vehicle_route = VehicleRoute.find(params[:id])
        if !@vehicle_route.is_finished
            enodeService = EnodeService.new
            vehicle = enodeService.get_enode_vehicle(@vehicle_route.vehicle_id)
            chargings = Charging.where(vehicle_route_id: @vehicle_route.id)
            chargingService = ChargingCreator.new

            @vehicle_route.end_time = Time.current
            @vehicle_route.battery_end = 30#vehicle['chargeState']['batteryLevel']
            @vehicle_route.is_finished = true
            total_battery_capacity = 220 * 0.9  #vehicle['chargeState']['batteryCapacity'] * #vehicle['chargeState']['chargingLimit']
            @vehicle_route.energy_used = chargingService.calculate_total_energy_used(@vehicle_route, chargings, total_battery_capacity)
            @vehicle_route.polyline = params[:polyline]
            

            if @vehicle_route.save
                render  json: {route: @vehicle_route, chargings: chargings}, status: :created
            else
                render json: @vehicle_route.errors, status: :unprocessable_entity
            end
        else 
            render json: { error: "Route has already finished" }, status: :unprocessable_entity
        end
        
    
    end

    def end_all_routes
        @vehicle_routes = VehicleRoute.where(is_finished: false)
        @vehicle_routes.each do |route|
            enodeService = EnodeService.new
            vehicle = enodeService.get_enode_vehicle(route.vehicle_id)
            chargings = Charging.where(vehicle_route_id: route.id)
            route.end_time = Time.current
            route.battery_end = 30#vehicle['chargeState']['batteryLevel']
            route.is_finished = true
            total_battery_capacity = 220 * 0.9 * #vehicle['chargeState']['batteryCapacity']
            route.energy_used = 0
            route.save
            

        end
        render json: @vehicle_routes.length
    end


end

private


def route_params
    params.require(:vehicle_route).permit(:id,:start_time, :end_time, :is_finished, :distance, :polyline, :batery_start, :batery_end, :user_id, :vehicle_id)

end


