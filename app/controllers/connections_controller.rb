class ConnectionsController < ApplicationController

    before_action :set_connection, only: [:show, :update, :destroy]
    before_action :authenticate_user!, only: [:create, :update, :destroy]

    def index
        render json: Connection.all
    end


    # GET /connections/:id
    def show
        if @connection
            render json: @connection
        else
            render json: { message: "Connection not found" }, status: :not_found
        end
    end

    # PATCH/PUT /connections/:id
    def update
        if @connection.update(connection_params)
            render json: @connection
        else
            render json: @connection.errors, status: :unprocessable_entity
        end
    end

    # POST /connections
    def create
        @connection = Connection.new(connection_params)
        @connection.created_by_id = current_user.id
        @connection.updated_by_id = current_user.id
        if @connection.save
            render json: @connection, status: :created
        else
            render json: @connection.errors, status: :unprocessable_entity
        end
    end

    # DELETE /connections/:id
    def destroy
        if @connection.destroy
            render json: { message: "Connection deleted successfully" }, status: :no_content
        else
            render json: @connection.errors, status: :unprocessable_entity
          
        end
    end

    private

    def set_connection
        @connection = Connection.find(params[:id])
    end

    def connection_params
        params.require(:connection).permit(
            :ev_station_id,
            :is_operational_status, 
            :is_fast_charge_capable, 
            :amps,
            :voltage,
            :power_kw,
            :quantity,
            :id,
            :created_by_id, 
            :updated_by_id, 
            :created_at,
            :current_type_id,
            :connection_type_id,
         )

         
    end
end
