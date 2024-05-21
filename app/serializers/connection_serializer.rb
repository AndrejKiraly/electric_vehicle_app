class ConnectionSerializer < ActiveModel::Serializer
  attributes :id, :ev_station_id, :amps, :voltage, :power_kw, :quantity, :created_at, :updated_at, :created_by_id, :updated_by_id, :charging_level, :current_type, :is_operational_status, :is_fast_charge_capable, :connection_type, :chargings

  belongs_to :chargings, serializer: ChargingSerializer
  belongs_to :connection_type, serializer: ConnectionTypeSerializer
  belongs_to :current_type, serializer: CurrentTypeSerializer
end
