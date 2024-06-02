class WebhooksController < ApplicationController

    def index
      render json: { message: 'Webhook index' }
    end
  
    def create
      # Handle the webhook POST request here
      # Access the request parameters using params[:param_name]
      # Process the webhook data and perform necessary actions
      # Extract the JSON array from the params
      events = params[:_json]
      
      # Create a hash to keep track of the most recent event for each vehicle
      latest_events = {}
  
      # Iterate through each event and store the latest event per vehicle
      events.each do |data|
        next unless data['event'] == 'user:vehicle:updated'
  
        vehicle_id = data['vehicle']['id']
        if latest_events[vehicle_id].nil? || latest_events[vehicle_id]['createdAt'] < data['createdAt']
          latest_events[vehicle_id] = data
        end
      end
  
      # Process each of the latest events
      latest_events.each do |vehicle_id, data|
        vehicle = data['vehicle']
        charge_state = vehicle['chargeState']
        power_delivery_state = charge_state['powerDeliveryState']
        user_id = data['user']['id']
  
        if power_delivery_state == 'PLUGGED_IN:CHARGING'
          # Create a charging record


          if VehicleRoute.find_by(vehicle_id: vehicle['id'], is_finished: false).nil?
            Charging.create(
            vehicle_id:vehicle['id'],
            vehicle_route_id: VehicleRoute.find_by(vehicle_id: vehicle['id'], is_finished: false).id,
            user_id: user_id,
            battery_level_start: charge_state['batteryLevel'],
            start_time: Time.current,
            coordinates: RGeo::Geographic.spherical_factory(srid: 4326).point(vehicle['location']['longitude'], vehicle['location']['latitude']),
            is_finished: false
          )

          end

          Charging.create(
            vehicle_id:vehicle['id'],
            user_id: user_id,
            battery_level_start: charge_state['batteryLevel'],
            start_time: Time.current,
            coordinates: RGeo::Geographic.spherical_factory(srid: 4326).point(vehicle['location']['longitude'], vehicle['location']['latitude']),
            is_finished: false
          )
        elsif %w[PLUGGED_IN:COMPLETE UNPLUGGED].include?(power_delivery_state)
          # Update charging record to finished
          charging = Charging.find_by(vehicle_id:, user_id:, is_finished: false)
          charging&.update(
            is_finished: true,
            battery_level_end: charge_state['batteryLevel'],
            energy_used: charge_state['batteryLevel'] - charging.battery_level_start * charge_state['batteryCapacity'] / 100.0,
            end_time: Time.current
          )
        end
      end
      render json: { message: 'Webhook received successfully'}, status: :ok
    end
  end
