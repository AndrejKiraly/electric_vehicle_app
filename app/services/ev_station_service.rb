class EvStationService
    





















    # def initialize(params)
    #   @params = params
    # end


    # def call
    #     if @params[:bounds_sw] && @params[:bounds_ne]
    #         return within_bounds(@params[:bounds_sw], @params[:bounds_ne])
    #     else
    #         return 
    #     end
    # end

    # def within_bounds(sw, ne)
    #     bounds_sw_lat = sw.split(",")[0].to_f
    #     bounds_ne_lat = ne.split(",")[0].to_f
    #     bounds_sw_lng = sw.split(",")[1].to_f
    #     bounds_ne_lng = ne.split(",")[1].to_f
    #     ev_stations = EvStation.all.where("latitude >= ? AND latitude <= ? AND longitude >= ? AND longitude <= ?", bounds_sw_lat, bounds_ne_lat, bounds_sw_lng, bounds_ne_lng)
    #     return ev_stations
    # end

    # def filter_stations
    #     ev_stations = ev_stations.where(is_free: @params[:is_free]) 
    #     ev_stations = ev_stations.where(usage_type_id: @params[:usage_type_id]) 
    #     ev_stations = ev_stations.includes(:connections).where(connections: {is_fast_charge_capable: @params[:is_fast_charge_capable]}) if @params[:is_fast_charge_capable].present?
    #     ev_stations = ev_stations.includes(:connections).where(connections: {current_type_id: @params[:current_type_id]}) if @params[:current_type_id].present?
    #     ev_stations = ev_stations.includes(:connections).where(connections: {connection_type_id: @params[:connection_type_id]}) if @params[:connection_type_id].present?
        
    #     ev_stations = ev_stations.includes(:connections).where(connections: {current_type_id: @params[:current_type_id]}) if @params[:current_type_id].present?
    #     ev_stations = ev_stations.where(
    #     id: Connection.select(:ev_station_id)
    #                     .where("power_kw > ?", @params[:power_kw]))if @params[:power_kw].present?

                        
        
    #     if @params[:amenity_ids].present?
    #     amenity_ids = @params[:amenity_ids].split(',').map(&:to_i)  # Ensure amenity_ids is an array of integers
    #     ev_stations = ev_stations.joins(:amenities).where(amenities: { id: amenity_ids }).distinct
    #     end

    #     if @params[:usage_type_ids].present?
    #     usage_type_ids = @params[:usage_type_ids].split(',').map(&:to_i)  # Ensure amenity_ids is an array of integers
    #     ev_stations = ev_stations.where(usage_type_id: usage_type_ids)
    #     end

    #     if @params[:connection_type_ids].present?
    #     connection_type_ids = @params[:connection_type_ids].split(',').map(&:to_i)  # Ensure amenity_ids is an array of integers
    #     ev_stations = ev_stations.joins(:connections).where(connections: { connection_type_id: connection_type_ids }).distinct
    #     end
        
    #     ev_stations = ev_stations.where("rating >= ?", @params[:rating]) if @params[:rating].present?
    #     ev_stations = ev_stations.includes(:connections).where(connections: {connection_type_id: @params[:connection_type_id]}) if @params[:connection_type_id].present?
    # end
end