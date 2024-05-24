# frozen_string_literal: true

namespace :battery do
    desc 'Update vehicle battery levels'
    task update: :environment do
      service = EnodeService.new
  
      Charging.where(is_finished: false).find_each do |charging|
        status = service.vehicle_status(charging.vehicle_id)
        if status && (charge_state = status['chargeState'])
          charging.update(battery_level_end: charge_state['batteryLevel'])
  
          battery_level_end = if charge_state['powerDeliveryState'].in?(%w[FINISHED UNPLUGGED])
                                charge_state['batteryLevel']
                              elsif charging.start_time + 2.days < Time.current
                                'Hard-Updated-48Hrs'
                              end
          
          if battery_level_end
            charging.update(
              is_finished: true,
              battery_level_end:,
              end_time: Time.current
            )
          end
        else
          Rails.logger.error("Failed to fetch vehicle status for vehicle_id #{charging.vehicle_id}")
        end
      end
    end
  end