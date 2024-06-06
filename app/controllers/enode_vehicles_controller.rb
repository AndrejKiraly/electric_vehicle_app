class EnodeVehiclesController < ApplicationController

    before_action :authenticate_user!, only: [:show_user_vehicles,:create,:show_vehicle,  :delete]


    

    def show_user_vehicles
        service = EnodeService.new
        enode_user_vehicles = service.get_enode_user_vehicles(current_user.id)
        data = enode_user_vehicles["data"]
        render json: enode_user_vehicles, status: :ok
    end

    def show_vehicle
        service = EnodeService.new
        enode_user_vehicle = service.get_enode_vehicle(params[:id])
        render json:  enode_user_vehicle.to_json, status: :ok
    end

    def create
        service = EnodeService.new
        enode_vehicle_link_url = service.enode_link_vehicle_to_user(current_user.id)
        if enode_vehicle_link_url.nil?
            render json: { message: 'Linking enode vehicle failed'}
        end
        render json: { message: 'Vehicle link url generated', user_id: current_user.id, link: enode_vehicle_link_url ['linkUrl']}
    end

    def delete
        begin
         service = EnodeService.new
         service.unlink_user(current_user.id)
            render json: { message: 'User unlinked from enode'}, status: :no_content
          rescue  => e
            debugger
            render json: { error: e.message }, status: :unprocessable_entity
          end
          
    end

    def show
        # Your code for the show method goes here
    end

    
end
