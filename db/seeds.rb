# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


ConnectionType.create([
  {
    id: 7,
    formal_name: "Avcon SAE J1772-2001",
    is_discontinued: true,
    is_obsolete: false,
    title: "Avcon Connector"
  },
  {
    id: 4,
    formal_name: nil,
    is_discontinued: nil,
    is_obsolete: nil,
    title: "Blue Commando (2P+E)"
  },
  {
    id: 3,
    formal_name: "BS1363 / Type G",
    is_discontinued: nil,
    is_obsolete: nil,
    title: "BS1363 3 Pin 13 Amp"
  },
  {
    id: 32,
    formal_name: "IEC 62196-3 Configuration EE",
    is_discontinued: false,
    is_obsolete: false,
    title: "CCS (Type 1)"
  },
  {
    id: 33,
    formal_name: "IEC 62196-3 Configuration FF",
    is_discontinued: false,
    is_obsolete: false,
    title: "CCS (Type 2)"
  },
  {
    id: 16,
    formal_name: nil,
    is_discontinued: false,
    is_obsolete: false,
    title: "CEE 3 Pin"
  },
  {
    id: 17,
    formal_name: nil,
    is_discontinued: false,
    is_obsolete: false,
    title: "CEE 5 Pin"
  },
  {
    id: 28,
    formal_name: "CEE 7/4",
    is_discontinued: false,
    is_obsolete: false,
    title: "CEE 7/4 - Schuko - Type F"
  },
  {
    id: 23,
    formal_name: nil,
    is_discontinued: false,
    is_obsolete: false,
    title: "CEE 7/5"
  },
  {
    id: 18,
    formal_name: nil,
    is_discontinued: false,
    is_obsolete: false,
    title: "CEE+ 7 Pin"
  },
  {
    id: 2,
    formal_name: "IEC 62196-3 Configuration AA",
    is_discontinued: nil,
    is_obsolete: nil,
    title: "CHAdeMO"
  },
  {
    id: 13,
    formal_name: "Europlug 2-Pin (CEE 7/16)",
    is_discontinued: false,
    is_obsolete: false,
    title: "Europlug 2-Pin (CEE 7/16)"
  },
  {
    id: 1038,
    formal_name: "GB-T AC - GB/T 20234.2 (Socket)",
    is_discontinued: false,
    is_obsolete: false,
    title: "GB-T AC - GB/T 20234.2 (Socket)"
  },
  {
    id: 1039,
    formal_name: "GB-T AC - GB/T 20234.2 (Tethered Cable)",
    is_discontinued: false,
    is_obsolete: false,
    title: "GB-T AC - GB/T 20234.2 (Tethered Cable)"
  },
  {
    id: 1040,
    formal_name: "GB-T DC - GB/T 20234.3",
    is_discontinued: false,
    is_obsolete: false,
    title: "GB-T DC - GB/T 20234.3"
  },
  {
    id: 34,
    formal_name: "IEC 60309 3-pin",
    is_discontinued: false,
    is_obsolete: false,
    title: "IEC 60309 3-pin"
  },
  {
    id: 35,
    formal_name: "IEC 60309 5-pin",
    is_discontinued: false,
    is_obsolete: false,
    title: "IEC 60309 5-pin"
  },
  {
    id: 5,
    formal_name: "Large Paddle Inductive",
    is_discontinued: true,
    is_obsolete: true,
    title: "LP Inductive"
  },
  {
    id: 27,
    formal_name: "SAE J3400",
    is_discontinued: false,
    is_obsolete: false,
    title: "NACS / Tesla Supercharger"
  },
  {
    id: 10,
    formal_name: nil,
    is_discontinued: false,
    is_obsolete: false,
    title: "NEMA 14-30"
  },
  {
    id: 11,
    formal_name: nil,
    is_discontinued: false,
    is_obsolete: false,
    title: "NEMA 14-50"
  },
  {
    id: 22,
    formal_name: "NEMA 5-15R",
    is_discontinued: false,
    is_obsolete: false,
    title: "NEMA 5-15R"
  },
  {
    id: 9,
    formal_name: nil,
    is_discontinued: false,
    is_obsolete: false,
    title: "NEMA 5-20R"
  },
  {
    id: 15,
    formal_name: nil,
    is_discontinued: false,
    is_obsolete: false,
    title: "NEMA 6-15"
  },
  {
    id: 14,
    formal_name: nil,
    is_discontinued: false,
    is_obsolete: false,
    title: "NEMA 6-20"
  },
  {
    id: 1042,
    formal_name: nil,
    is_discontinued: false,
    is_obsolete: false,
    title: "NEMA TT-30R"
  },
  {
    id: 36,
    formal_name: nil,
    is_discontinued: false,
    is_obsolete: false,
    title: "SCAME Type 3A (Low Power)"
  },
  {
    id: 26,
    formal_name: "IEC 62196-2 Type 3",
    is_discontinued: false,
    is_obsolete: false,
    title: "SCAME Type 3C (Schneider-Legrand)"
  },
  {
    id: 6,
    formal_name: "Small Paddle Inductive",
    is_discontinued: true,
    is_obsolete: true,
    title: "SP Inductive"
  },
  {
    id: 1037,
    formal_name: "T13/ IEC Type J",
    is_discontinued: false,
    is_obsolete: false,
    title: "T13 - SEC1011 ( Swiss domestic 3-pin ) - Type J"
  },
  {
    id: 30,
    formal_name: nil,
    is_discontinued: false,
    is_obsolete: false,
    title: "Tesla (Model S/X)"
  },
  {
    id: 8,
    formal_name: "Tesla Connector",
    is_discontinued: true,
    is_obsolete: false,
    title: "Tesla (Roadster)"
  },
  {
    id: 31,
    formal_name: "Tesla Battery Swap Station",
    is_discontinued: false,
    is_obsolete: false,
    title: "Tesla Battery Swap"
  },
  {
    id: 1041,
    formal_name: "AS/NZS 3123 Three Phase",
    is_discontinued: false,
    is_obsolete: false,
    title: "Three Phase 5-Pin (AS/NZ 3123)"
  },
  {
    id: 1,
    formal_name: "SAE J1772-2009",
    is_discontinued: nil,
    is_obsolete: nil,
    title: "Type 1 (J1772)"
  },
  {
    id: 25,
    formal_name: "IEC 62196-2 Type 2",
    is_discontinued: false,
    is_obsolete: false,
    title: "Type 2 (Socket Only)"
  },
  {
    id: 1036,
    formal_name: "IEC 62196-2",
    is_discontinued: false,
    is_obsolete: false,
    title: "Type 2 (Tethered Connector) "
  },
  {
    id: 29,
    formal_name: "Type I/AS 3112/CPCS-CCC",
    is_discontinued: false,
    is_obsolete: false,
    title: "Type I (AS 3112)"
  },
  {
    id: 1043,
    formal_name: "IEC Type M (SANS 164-1, IS 1293:2005)",
    is_discontinued: false,
    is_obsolete: false,
    title: "Type M"
  },
  {
    id: 0,
    formal_name: "Not Specified",
    is_discontinued: nil,
    is_obsolete: nil,
    title: "Unknown"
  },
  {
    id: 24,
    formal_name: nil,
    is_discontinued: false,
    is_obsolete: false,
    title: "Wireless Charging"
  },
  {
    id: 21,
    formal_name: nil,
    is_discontinued: false,
    is_obsolete: false,
    title: "XLR Plug (4 pin)"
  }
]
)

UsageType.create([
  {
    id: 0,
    is_pay_at_location: nil,
    is_membership_required: nil,
    is_access_key_required: nil,
    title: "(Unknown)"
  },
  {
    id: 6,
    is_pay_at_location: false,
    is_membership_required: false,
    is_access_key_required: false,
    title: "Private - For Staff, Visitors or Customers"
  },
  {
    id: 2,
    is_pay_at_location: nil,
    is_membership_required: true,
    is_access_key_required: nil,
    title: "Private - Restricted Access"
  },
  {
    id: 3,
    is_pay_at_location: nil,
    is_membership_required: nil,
    is_access_key_required: nil,
    title: "Privately Owned - Notice Required"
  },
  {
    id: 1,
    is_pay_at_location: nil,
    is_membership_required: nil,
    is_access_key_required: nil,
    title: "Public"
  },
  {
    id: 4,
    is_pay_at_location: false,
    is_membership_required: true,
    is_access_key_required: true,
    title: "Public - Membership Required"
  },
  {
    id: 7,
    is_pay_at_location: false,
    is_membership_required: false,
    is_access_key_required: false,
    title: "Public - Notice Required"
  },
  {
    id: 5,
    is_pay_at_location: true,
    is_membership_required: false,
    is_access_key_required: false,
    title: "Public - Pay At Location"
  }
])

Amenity.create([
    {id: 1, title: "Toilets"},
    {id: 2, title: "Shopping Mall"},
    {id: 3, title: "Restaurant"},
    {id: 4, title: "Hotel"},
    {id: 5, title: "Parking Lot"},
    {id: 6, title: "ATM"},
    {id: 7, title: "WiFi"},
    {id: 8, title: "Park"},
    {id: 9, title: "Supermarket"},
])

CurrentType.create([
  {
    description: "Alternating Current - Single Phase",
    id: 10,
    title: "AC (Single-Phase)"
  },
  {
    description: "Alternating Current - Three Phase",
    id: 20,
    title: "AC (Three-Phase)"
  },
  {
    description: "Direct Current",
    id: 30,
    title: "DC"
  }
])
