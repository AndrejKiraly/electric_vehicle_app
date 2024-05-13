module ChargingLibrary
    TAX_FEE = 0.2

    def self.calculateChargingTime(battery_level, connection_power, battery_capacity, charge_limit, max_current)
        batery_current_hz = battery_level / 100 * battery_capacity 
        charging_hz = max_current < connection_power ? max_current : connection_power
        charging_time = battery_current_hz * charge_limit/100 /charging_hz
        puts charging_time
    end
end
    









    # def self.included(base)
    #     base.class_eval do
    #         def self.charging_module
    #             include ChargingModule::InstanceMethods
    #             extend ChargingModule::ClassMethods
    #         end
    #     end
    # end

    # module InstanceMethods
    #     def charge
    #         puts "Charging..."
    #     end
    # end

    # module ClassMethods
    #     def charging_speed
    #         puts "Charging speed is 50kW"
    #     end
    # end
