class MonthChargingSummarySerializer < ActiveModel::Serializer
  attributes :total_charging_cost, :total_energy_used, :chargings

  has_many :chargings, serializer: ChargingSerializer 

  def read_attribute_for_serialization(attr)
    object[attr.to_sym] # Convert attribute to a symbol before accessing the hash
  end

  
  def total_charging_price
    object.sum(&:price)  
  end

  def total_energy_used
    object.sum(&:energy_used) 
  end
end
