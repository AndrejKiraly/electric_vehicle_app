# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end




countries_data = [
  { iso_code: "GB", continent_code: "EU", id: 1, title: "United Kingdom" },
  { iso_code: "US", continent_code: "NA", id: 2, title: "United States" },
  { iso_code: "IE", continent_code: "EU", id: 3, title: "Ireland" },
  { iso_code: "HK", continent_code: "AS", id: 4, title: "Hong Kong" },
  { iso_code: "AF", continent_code: "AS", id: 5, title: "Afghanistan" },
  { iso_code: "AX", continent_code: "EU", id: 6, title: "Aland Islands" },
  { iso_code: "AL", continent_code: "EU", id: 7, title: "Albania" },
  { iso_code: "DZ", continent_code: "AF", id: 8, title: "Algeria" },
  { iso_code: "AS", continent_code: "OC", id: 9, title: "American Samoa" },
  { iso_code: "AD", continent_code: "EU", id: 10, title: "Andorra" },
  { iso_code: "AO", continent_code: "AF", id: 11, title: "Angola" },
  { iso_code: "AI", continent_code: "NA", id: 12, title: "Anguilla" },
  { iso_code: "AQ", continent_code: "AN", id: 13, title: "Antarctica" },
  { iso_code: "AG", continent_code: "NA", id: 14, title: "Antigua And Barbuda" },
  { iso_code: "AR", continent_code: "SA", id: 15, title: "Argentina" },
  { iso_code: "AM", continent_code: "AS", id: 16, title: "Armenia" },
  { iso_code: "AW", continent_code: "NA", id: 17, title: "Aruba" },
  { iso_code: "AU", continent_code: "OC", id: 18, title: "Australia" },
  { iso_code: "AT", continent_code: "EU", id: 19, title: "Austria" },
  { iso_code: "AZ", continent_code: "AS", id: 20, title: "Azerbaijan" },
  { iso_code: "BS", continent_code: "NA", id: 21, title: "Bahamas" },
  { iso_code: "BH", continent_code: "AS", id: 22, title: "Bahrain" },
  { iso_code: "BD", continent_code: "AS", id: 23, title: "Bangladesh" },
  { iso_code: "BB", continent_code: "NA", id: 24, title: "Barbados" },
  { iso_code: "BY", continent_code: "EU", id: 25, title: "Belarus" },
  { iso_code: "BE", continent_code: "EU", id: 26, title: "Belgium" },
  { iso_code: "BZ", continent_code: "NA", id: 27, title: "Belize" },
  { iso_code: "BJ", continent_code: "AF", id: 28, title: "Benin" },
  { iso_code: "BM", continent_code: "NA", id: 29, title: "Bermuda" },
  { iso_code: "BT", continent_code: "AS", id: 30, title: "Bhutan" },
  { iso_code: "BO", continent_code: "SA", id: 31, title: "Bolivia, Plurinational State Of" },
  { iso_code: "BQ", continent_code: nil, id: 32, title: "Bonaire, Saint Eustatius And Saba" },
  { iso_code: "BA", continent_code: "EU", id: 33, title: "Bosnia And Herzegovina" },
  { iso_code: "BW", continent_code: "AF", id: 34, title: "Botswana" },
  { iso_code: "BV", continent_code: "AN", id: 35, title: "Bouvet Island" },
  { iso_code: "BR", continent_code: "SA", id: 36, title: "Brazil" },
  { iso_code: "IO", continent_code: "AS", id: 37, title: "British Indian Ocean Territory" },
  { iso_code: "BN", continent_code: "AS", id: 38, title: "Brunei Darussalam" },
  { iso_code: "BG", continent_code: "EU", id: 39, title: "Bulgaria" },
  { iso_code: "BF", continent_code: "AF", id: 40, title: "Burkina Faso" },
  { iso_code: "BI", continent_code: "AF", id: 41, title: "Burundi" },
  { iso_code: "KH", continent_code: "AS", id: 42, title: "Cambodia" },
  { iso_code: "CM", continent_code: "AF", id: 43, title: "Cameroon" },
  { iso_code: "CA", continent_code: "NA", id: 44, title: "Canada" },
  { iso_code: "CV", continent_code: "AF", id: 45, title: "Cape Verde" },
  { iso_code: "KY", continent_code: "NA", id: 46, title: "Cayman Islands" },
  { iso_code: "CF", continent_code: "AF", id: 47, title: "Central African Republic" },
  { iso_code: "TD", continent_code: "AF", id: 48, title: "Chad" },
  { iso_code: "CL", continent_code: "SA", id: 49, title: "Chile" },
  { iso_code: "CN", continent_code: "AS", id: 50, title: "China" },
  { iso_code: "CX", continent_code: "AS", id: 51, title: "Christmas Island" },
  { iso_code: "CC", continent_code: "AS", id: 52, title: "Cocos (Keeling) Islands" },
  { iso_code: "CO", continent_code: "SA", id: 53, title: "Colombia" },
  { iso_code: "KM", continent_code: "AF", id: 54, title: "Comoros" },
  { iso_code: "CG", continent_code: "AF", id: 55, title: "Congo" },
  { iso_code: "CD", continent_code: "AF", id: 56, title: "Congo, Democratic Republic Of The" },
  { iso_code: "CK", continent_code: "OC", id: 57, title: "Cook Islands" },
  { iso_code: "CR", continent_code: "NA", id: 58, title: "Costa Rica" },
  { iso_code: "CI", continent_code: "AF", id: 59, title: "Cote D'Ivoire" },
  { iso_code: "HR", continent_code: "EU", id: 60, title: "Croatia" },
  { iso_code: "CU", continent_code: "NA", id: 61, title: "Cuba" },
  { iso_code: "CW", continent_code: nil, id: 62, title: "Curacao" },
  { iso_code: "CY", continent_code: "AS", id: 63, title: "Cyprus" },
  { iso_code: "CZ", continent_code: "EU", id: 64, title: "Czech Republic" },
  { iso_code: "DK", continent_code: "EU", id: 65, title: "Denmark" },
  { iso_code: "DJ", continent_code: "AF", id: 66, title: "Djibouti" },
  { iso_code: "DM", continent_code: "NA", id: 67, title: "Dominica" },
  { iso_code: "DO", continent_code: "NA", id: 68, title: "Dominican Republic" },
  { iso_code: "EC", continent_code: "SA", id: 69, title: "Ecuador" },
  { iso_code: "EG", continent_code: "AF", id: 70, title: "Egypt" },
  { iso_code: "SV", continent_code: "NA", id: 71, title: "El Salvador" },
  { iso_code: "GQ", continent_code: "AF", id: 72, title: "Equatorial Guinea" },
  { iso_code: "ER", continent_code: "AF", id: 73, title: "Eritrea" },
  { iso_code: "EE", continent_code: "EU", id: 74, title: "Estonia" },
  { iso_code: "ET", continent_code: "AF", id: 75, title: "Ethiopia" },
  { iso_code: "FK", continent_code: "SA", id: 76, title: "Falkland Islands (Malvinas)" },
  { iso_code: "FO", continent_code: "EU", id: 77, title: "Faroe Islands" },
  { iso_code: "FJ", continent_code: "OC", id: 78, title: "Fiji" },
  { iso_code: "FI", continent_code: "EU", id: 79, title: "Finland" },
  { iso_code: "FR", continent_code: "EU", id: 80, title: "France" },
  { iso_code: "GF", continent_code: "SA", id: 81, title: "French Guiana" },
  { iso_code: "PF", continent_code: "OC", id: 82, title: "French Polynesia" },
  { iso_code: "TF", continent_code: "AN", id: 83, title: "French Southern Territories" },
  { iso_code: "GA", continent_code: "AF", id: 84, title: "Gabon" },
  { iso_code: "GM", continent_code: "AF", id: 85, title: "Gambia" },
  { iso_code: "GE", continent_code: "AS", id: 86, title: "Georgia" },
  { iso_code: "DE", continent_code: "EU", id: 87, title: "Germany" },
  { iso_code: "GH", continent_code: "AF", id: 88, title: "Ghana" },
  { iso_code: "GI", continent_code: "EU", id: 89, title: "Gibraltar" },
  { iso_code: "GR", continent_code: "EU", id: 90, title: "Greece" },
  { iso_code: "GL", continent_code: "NA", id: 91, title: "Greenland" },
  { iso_code: "GD", continent_code: "NA", id: 92, title: "Grenada" },
  { iso_code: "GP", continent_code: "NA", id: 93, title: "Guadeloupe" },
  { iso_code: "GU", continent_code: "OC", id: 94, title: "Guam" },
  { iso_code: "GT", continent_code: "NA", id: 95, title: "Guatemala" },
  { iso_code: "GG", continent_code: "EU", id: 96, title: "Guernsey" },
  { iso_code: "GN", continent_code: "AF", id: 97, title: "Guinea" },
  { iso_code: "GW", continent_code: "AF", id: 98, title: "Guinea-Bissau" },
  { iso_code: "GY", continent_code: "SA", id: 99, title: "Guyana" },
  { iso_code: "HT", continent_code: "NA", id: 100, title: "Haiti" },
  { iso_code: "HM", continent_code: "AN", id: 101, title: "Heard Island And Mcdonald Islands" },
  { iso_code: "VA", continent_code: "EU", id: 102, title: "Holy See (Vatican City State)" },
  { iso_code: "HN", continent_code: "NA", id: 103, title: "Honduras" },
  { iso_code: "HU", continent_code: "EU", id: 104, title: "Hungary" },
  { iso_code: "IS", continent_code: "EU", id: 105, title: "Iceland" },
  { iso_code: "IN", continent_code: "AS", id: 106, title: "India" },
  { iso_code: "id", continent_code: "AS", id: 107, title: "Indonesia" },
  { iso_code: "IR", continent_code: "AS", id: 108, title: "Iran, Islamic Republic Of" },
  { iso_code: "IQ", continent_code: "AS", id: 109, title: "Iraq" },
  { iso_code: "IM", continent_code: "EU", id: 110, title: "Isle Of Man" },
  { iso_code: "IL", continent_code: "AS", id: 111, title: "Israel" },
  { iso_code: "IT", continent_code: "EU", id: 112, title: "Italy" },
  { iso_code: "JM", continent_code: "NA", id: 113, title: "Jamaica" },
  { iso_code: "JP", continent_code: "AS", id: 114, title: "Japan" },
  { iso_code: "JE", continent_code: "EU", id: 115, title: "Jersey" },
  { iso_code: "JO", continent_code: "AS", id: 116, title: "Jordan" },
  { iso_code: "KZ", continent_code: "AS", id: 117, title: "Kazakhstan" },
  { iso_code: "KE", continent_code: "AF", id: 118, title: "Kenya" },
  { iso_code: "KI", continent_code: "OC", id: 119, title: "Kiribati" },
  { iso_code: "KP", continent_code: "AS", id: 120, title: "Korea, Democratic People's Rep." },
  { iso_code: "KR", continent_code: "AS", id: 121, title: "Korea, Republic Of" },
  { iso_code: "KW", continent_code: "AS", id: 122, title: "Kuwait" },
  { iso_code: "KG", continent_code: "AS", id: 123, title: "Kyrgyzstan" },
  { iso_code: "LA", continent_code: "AS", id: 124, title: "Lao People's Democratic Republic" },
  { iso_code: "LV", continent_code: "EU", id: 125, title: "Latvia" },
  { iso_code: "LB", continent_code: "AS", id: 126, title: "Lebanon" },
  { iso_code: "LS", continent_code: "AF", id: 127, title: "Lesotho" },
  { iso_code: "LR", continent_code: "AF", id: 128, title: "Liberia" },
  { iso_code: "LY", continent_code: "AF", id: 129, title: "Libyan Arab Jamahiriya" },
  { iso_code: "LI", continent_code: "EU", id: 130, title: "Liechtenstein" },
  { iso_code: "LT", continent_code: "EU", id: 131, title: "Lithuania" },
  { iso_code: "LU", continent_code: "EU", id: 132, title: "Luxembourg" },
  { iso_code: "MO", continent_code: "AS", id: 133, title: "Macao" },
  { iso_code: "MK", continent_code: "EU", id: 134, title: "Macedonia" },
  { iso_code: "MG", continent_code: "AF", id: 135, title: "Madagascar" },
  { iso_code: "MW", continent_code: "AF", id: 136, title: "Malawi" },
  { iso_code: "MY", continent_code: "AS", id: 137, title: "Malaysia" },
  { iso_code: "MV", continent_code: "AS", id: 138, title: "Maldives" },
  { iso_code: "ML", continent_code: "AF", id: 139, title: "Mali" },
  { iso_code: "MT", continent_code: "EU", id: 140, title: "Malta" },
  { iso_code: "MH", continent_code: "OC", id: 141, title: "Marshall Islands" },
  { iso_code: "MQ", continent_code: "NA", id: 142, title: "Martinique" },
  { iso_code: "MR", continent_code: "AF", id: 143, title: "Mauritania" },
  { iso_code: "MU", continent_code: "AF", id: 144, title: "Mauritius" },
  { iso_code: "YT", continent_code: "AF", id: 145, title: "Mayotte" },
  { iso_code: "MX", continent_code: "NA", id: 146, title: "Mexico" },
  { iso_code: "FM", continent_code: "OC", id: 147, title: "Micronesia, Federated States Of" },
  { iso_code: "MD", continent_code: "EU", id: 148, title: "Moldova, Republic Of" },
  { iso_code: "MC", continent_code: "EU", id: 149, title: "Monaco" },
  { iso_code: "MN", continent_code: "AS", id: 150, title: "Mongolia" },
  { iso_code: "ME", continent_code: "EU", id: 151, title: "Montenegro" },
  { iso_code: "MS", continent_code: "NA", id: 152, title: "Montserrat" },
  { iso_code: "MA", continent_code: "AF", id: 153, title: "Morocco" },
  { iso_code: "MZ", continent_code: "AF", id: 154, title: "Mozambique" },
  { iso_code: "MM", continent_code: "AS", id: 155, title: "Myanmar" },
  { iso_code: "NA", continent_code: "AF", id: 156, title: "Namibia" },
  { iso_code: "NR", continent_code: "OC", id: 157, title: "Nauru" },
  { iso_code: "NP", continent_code: "AS", id: 158, title: "Nepal" },
  { iso_code: "NL", continent_code: "EU", id: 159, title: "Netherlands" },
  { iso_code: "NC", continent_code: "OC", id: 160, title: "New Caledonia" },
  { iso_code: "NZ", continent_code: "OC", id: 161, title: "New Zealand" },
  { iso_code: "NI", continent_code: "NA", id: 162, title: "Nicaragua" },
  { iso_code: "NE", continent_code: "AF", id: 163, title: "Niger" },
  { iso_code: "NG", continent_code: "AF", id: 164, title: "Nigeria" },
  { iso_code: "NU", continent_code: "OC", id: 165, title: "Niue" },
  { iso_code: "NF", continent_code: "OC", id: 166, title: "Norfolk Island" },
  { iso_code: "MP", continent_code: "OC", id: 167, title: "Northern Mariana Islands" },
  { iso_code: "NO", continent_code: "EU", id: 168, title: "Norway" },
  { iso_code: "OM", continent_code: "AS", id: 169, title: "Oman" },
  { iso_code: "PK", continent_code: "AS", id: 170, title: "Pakistan" },
  { iso_code: "PW", continent_code: "OC", id: 171, title: "Palau" },
  { iso_code: "PS", continent_code: "AS", id: 172, title: "Palestinian Territory, Occupied" },
  { iso_code: "PA", continent_code: "NA", id: 173, title: "Panama" },
  { iso_code: "PG", continent_code: "OC", id: 174, title: "Papua New Guinea" },
  { iso_code: "PY", continent_code: "SA", id: 175, title: "Paraguay" },
  { iso_code: "PE", continent_code: "SA", id: 176, title: "Peru" },
  { iso_code: "PH", continent_code: "AS", id: 177, title: "Philippines" },
  { iso_code: "PN", continent_code: "OC", id: 178, title: "Pitcairn" },
  { iso_code: "PL", continent_code: "EU", id: 179, title: "Poland" },
  { iso_code: "PT", continent_code: "EU", id: 180, title: "Portugal" },
  { iso_code: "PR", continent_code: "NA", id: 181, title: "Puerto Rico" },
  { iso_code: "QA", continent_code: "AS", id: 182, title: "Qatar" },
  { iso_code: "RE", continent_code: "AF", id: 183, title: "Reunion" },
  { iso_code: "RO", continent_code: "EU", id: 184, title: "Romania" },
  { iso_code: "RU", continent_code: "EU", id: 185, title: "Russian Federation" },
  { iso_code: "RW", continent_code: "AF", id: 186, title: "Rwanda" },
  { iso_code: "BL", continent_code: "NA", id: 187, title: "Saint Barthelemy" },
  { iso_code: "SH", continent_code: "AF", id: 188, title: "Saint Helena" },
  { iso_code: "KN", continent_code: "NA", id: 189, title: "Saint Kitts And Nevis" },
  { iso_code: "LC", continent_code: "NA", id: 190, title: "Saint Lucia" },
  { iso_code: "MF", continent_code: "NA", id: 191, title: "Saint Martin (French Part)" },
  { iso_code: "PM", continent_code: "NA", id: 192, title: "Saint Pierre And Miquelon" },
  { iso_code: "VC", continent_code: "NA", id: 193, title: "Saint Vincent And The Grenadines" },
  { iso_code: "WS", continent_code: "OC", id: 194, title: "Samoa" },
  { iso_code: "SM", continent_code: "EU", id: 195, title: "San Marino" },
  { iso_code: "ST", continent_code: "AF", id: 196, title: "Sao Tome And Principe" },
  { iso_code: "SA", continent_code: "AS", id: 197, title: "Saudi Arabia" },
  { iso_code: "SN", continent_code: "AF", id: 198, title: "Senegal" },
  { iso_code: "RS", continent_code: "EU", id: 199, title: "Serbia" },
  { iso_code: "SC", continent_code: "AF", id: 200, title: "Seychelles" },
  { iso_code: "SL", continent_code: "AF", id: 201, title: "Sierra Leone" },
  { iso_code: "SG", continent_code: "AS", id: 202, title: "Singapore" },
  { iso_code: "SX", continent_code: nil, id: 203, title: "Sint Maarten (Dutch Part)" },
  { iso_code: "SK", continent_code: "EU", id: 204, title: "Slovakia" },
  { iso_code: "SI", continent_code: "EU", id: 205, title: "Slovenia" },
  { iso_code: "SB", continent_code: "OC", id: 206, title: "Solomon Islands" },
  { iso_code: "SO", continent_code: "AF", id: 207, title: "Somalia" },
  { iso_code: "ZA", continent_code: "AF", id: 208, title: "South Africa" },
  { iso_code: "GS", continent_code: "AN", id: 209, title: "South Georgia" },
  { iso_code: "ES", continent_code: "EU", id: 210, title: "Spain" },
  { iso_code: "LK", continent_code: "AS", id: 211, title: "Sri Lanka" },
  { iso_code: "SD", continent_code: "AF", id: 212, title: "Sudan" },
  { iso_code: "SR", continent_code: "SA", id: 213, title: "Suriname" },
  { iso_code: "SJ", continent_code: "EU", id: 214, title: "Svalbard And Jan Mayen" },
  { iso_code: "SZ", continent_code: "AF", id: 215, title: "Swaziland" },
  { iso_code: "SE", continent_code: "EU", id: 216, title: "Sweden" },
  { iso_code: "CH", continent_code: "EU", id: 217, title: "Switzerland" },
  { iso_code: "SY", continent_code: "AS", id: 218, title: "Syrian Arab Republic" },
  { iso_code: "TW", continent_code: "AS", id: 219, title: "Taiwan, Province Of China" },
  { iso_code: "TJ", continent_code: "AS", id: 220, title: "Tajikistan" },
  { iso_code: "TZ", continent_code: "AF", id: 221, title: "Tanzania, United Republic Of" },
  { iso_code: "TH", continent_code: "AS", id: 222, title: "Thailand" },
  { iso_code: "TL", continent_code: "AS", id: 223, title: "Timor-Leste" },
  { iso_code: "TG", continent_code: "AF", id: 224, title: "Togo" },
  { iso_code: "TK", continent_code: "OC", id: 225, title: "Tokelau" },
  { iso_code: "TO", continent_code: "OC", id: 226, title: "Tonga" },
  { iso_code: "TT", continent_code: "NA", id: 227, title: "Trinidad And Tobago" },
  { iso_code: "TN", continent_code: "AF", id: 228, title: "Tunisia" },
  { iso_code: "TR", continent_code: "EU", id: 229, title: "Turkey" },
  { iso_code: "TM", continent_code: "AS", id: 230, title: "Turkmenistan" },
  { iso_code: "TC", continent_code: "NA", id: 231, title: "Turks And Caicos Islands" },
  { iso_code: "TV", continent_code: "OC", id: 232, title: "Tuvalu" },
  { iso_code: "UG", continent_code: "AF", id: 233, title: "Uganda" },
  { iso_code: "UA", continent_code: "EU", id: 234, title: "Ukraine" },
  { iso_code: "AE", continent_code: "AS", id: 235, title: "United Arab Emirates" },
  { iso_code: "UM", continent_code: "OC", id: 236, title: "United States Minor Outlying Islands" },
  { iso_code: "UY", continent_code: "SA", id: 237, title: "Uruguay" },
  { iso_code: "UZ", continent_code: "AS", id: 238, title: "Uzbekistan" },
  { iso_code: "VU", continent_code: "OC", id: 239, title: "Vanuatu" },
  { iso_code: "VE", continent_code: "SA", id: 240, title: "Venezuela, Bolivarian Republic Of" },
  { iso_code: "VN", continent_code: "AS", id: 241, title: "Viet Nam" },
  { iso_code: "VG", continent_code: "NA", id: 242, title: "Virgin Islands, British" },
  { iso_code: "VI", continent_code: "NA", id: 243, title: "Virgin Islands, U.S." },
  { iso_code: "WF", continent_code: "OC", id: 244, title: "Wallis And Futuna" },
  { iso_code: "EH", continent_code: "AF", id: 245, title: "Western Sahara" },
  { iso_code: "YE", continent_code: "AS", id: 246, title: "Yemen" },
  { iso_code: "ZM", continent_code: "AF", id: 247, title: "Zambia" },
  { iso_code: "ZW", continent_code: "AF", id: 248, title: "Zimbabwe" },
  { iso_code: "SS", continent_code: "AF", id: 249, title: "South Sudan" },
  { iso_code: "XK", continent_code: "EU", id: 250, title: "Kosovo" }
]
# db/seeds.rb

current_types_data = [
  { id: 10, description: "Alternating Current - Single Phase", title: "AC (Single-Phase)" },
  { id: 20, description: "Alternating Current - Three Phase", title: "AC (Three-Phase)" },
  { id: 30, description: "Direct Current", title: "DC" }
]

source_data = [
  {id:1, title: "OpenChargeMaps"},
  {id:2, title: "Added from Mobile App"},
]

amenities_data = [
  { id: 1, title: "Toilets" },
  { id: 2, title: "Shopping Mall" },
  { id: 3, title: "Restaurant" },
  { id: 4, title: "Hotel" },
  { id: 5, title: "Parking Lot" },
  { id: 6, title: "ATM" },
  { id: 7, title: "WiFi" },
  { id: 8, title: "Park" },
  { id: 9, title: "Supermarket" }
]

usage_types_data = [
  { id: 0, is_pay_at_location: nil, is_membership_required: nil, is_access_key_required: nil, title: "(Unknown)" },
  { id: 6, is_pay_at_location: false, is_membership_required: false, is_access_key_required: false, title: "Private - For Staff, Visitors or Customers" },
  { id: 2, is_pay_at_location: nil, is_membership_required: true, is_access_key_required: nil, title: "Private - Restricted Access" },
  { id: 3, is_pay_at_location: nil, is_membership_required: nil, is_access_key_required: nil, title: "Privately Owned - Notice Required" },
  { id: 1, is_pay_at_location: nil, is_membership_required: nil, is_access_key_required: nil, title: "Public" },
  { id: 4, is_pay_at_location: false, is_membership_required: true, is_access_key_required: true, title: "Public - Membership Required" },
  { id: 7, is_pay_at_location: false, is_membership_required: false, is_access_key_required: false, title: "Public - Notice Required" },
  { id: 5, is_pay_at_location: true, is_membership_required: false, is_access_key_required: false, title: "Public - Pay At Location" }
]


connection_types_data = [
  { id: 7, formal_name: "Avcon SAE J1772-2001", is_discontinued: true, is_obsolete: false, title: "Avcon Connector" },
  { id: 4, formal_name: nil, is_discontinued: nil, is_obsolete: nil, title: "Blue Commando (2P+E)" },
  { id: 3, formal_name: "BS1363 / Type G", is_discontinued: nil, is_obsolete: nil, title: "BS1363 3 Pin 13 Amp" },
  { id: 32, formal_name: "IEC 62196-3 Configuration EE", is_discontinued: false, is_obsolete: false, title: "CCS (Type 1)" },
  { id: 33, formal_name: "IEC 62196-3 Configuration FF", is_discontinued: false, is_obsolete: false, title: "CCS (Type 2)" },
  { id: 16, formal_name: nil, is_discontinued: false, is_obsolete: false, title: "CEE 3 Pin" },
  { id: 17, formal_name: nil, is_discontinued: false, is_obsolete: false, title: "CEE 5 Pin" },
  { id: 28, formal_name: "CEE 7/4", is_discontinued: false, is_obsolete: false, title: "CEE 7/4 - Schuko - Type F" },
  { id: 23, formal_name: nil, is_discontinued: false, is_obsolete: false, title: "CEE 7/5" },
  { id: 18, formal_name: nil, is_discontinued: false, is_obsolete: false, title: "CEE+ 7 Pin" },
  { id: 2, formal_name: "IEC 62196-3 Configuration AA", is_discontinued: nil, is_obsolete: nil, title: "CHAdeMO" },
  { id: 13, formal_name: "Europlug 2-Pin (CEE 7/16)", is_discontinued: false, is_obsolete: false, title: "Europlug 2-Pin (CEE 7/16)" },
  { id: 1038, formal_name: "GB-T AC - GB/T 20234.2 (Socket)", is_discontinued: false, is_obsolete: false, title: "GB-T AC - GB/T 20234.2 (Socket)" },
  { id: 1039, formal_name: "GB-T AC - GB/T 20234.2 (Tethered Cable)", is_discontinued: false, is_obsolete: false, title: "GB-T AC - GB/T 20234.2 (Tethered Cable)" },
  { id: 1040, formal_name: "GB-T DC - GB/T 20234.3", is_discontinued: false, is_obsolete: false, title: "GB-T DC - GB/T 20234.3" },
  { id: 34, formal_name: "IEC 60309 3-pin", is_discontinued: false, is_obsolete: false, title: "IEC 60309 3-pin" },
  { id: 35, formal_name: "IEC 60309 5-pin", is_discontinued: false, is_obsolete: false, title: "IEC 60309 5-pin" },
  { id: 5, formal_name: "Large Paddle Inductive", is_discontinued: true, is_obsolete: true, title: "LP Inductive" },
  { id: 27, formal_name: "SAE J3400", is_discontinued: false, is_obsolete: false, title: "NACS / Tesla Supercharger" },
  { id: 10, formal_name: nil, is_discontinued: false, is_obsolete: false, title: "NEMA 14-30" },
  { id: 11, formal_name: nil, is_discontinued: false, is_obsolete: false, title: "NEMA 14-50" },
  { id: 22, formal_name: "NEMA 5-15R", is_discontinued: false, is_obsolete: false, title: "NEMA 5-15R" },
  { id: 9, formal_name: nil, is_discontinued: false, is_obsolete: false, title: "NEMA 5-20R" },
  { id: 15, formal_name: nil, is_discontinued: false, is_obsolete: false, title: "NEMA 6-15" },
  { id: 14, formal_name: nil, is_discontinued: false, is_obsolete: false, title: "NEMA 6-20" },
  { id: 1042, formal_name: nil, is_discontinued: false, is_obsolete: false, title: "NEMA TT-30R" },
  { id: 36, formal_name: nil, is_discontinued: false, is_obsolete: false, title: "SCAME Type 3A (Low Power)" },
  { id: 26, formal_name: "IEC 62196-2 Type 3", is_discontinued: false, is_obsolete: false, title: "SCAME Type 3C (Schneider-Legrand)" },
  { id: 6, formal_name: "Small Paddle Inductive", is_discontinued: true, is_obsolete: true, title: "SP Inductive" },
  { id: 1037, formal_name: "T13/ IEC Type J", is_discontinued: false, is_obsolete: false, title: "T13 - SEC1011 ( Swiss domestic 3-pin ) - Type J" },
  { id: 30, formal_name: nil, is_discontinued: false, is_obsolete: false, title: "Tesla (Model S/X)" },
  { id: 8, formal_name: "Tesla Connector", is_discontinued: true, is_obsolete: false, title: "Tesla (Roadster)" },
  { id: 31, formal_name: "Tesla Battery Swap Station", is_discontinued: false, is_obsolete: false, title: "Tesla Battery Swap" },
  { id: 1041, formal_name: "AS/NZS 3123 Three Phase", is_discontinued: false, is_obsolete: false, title: "Three Phase 5-Pin (AS/NZ 3123)" },
  { id: 1, formal_name: "SAE J1772-2009", is_discontinued: nil, is_obsolete: nil, title: "Type 1 (J1772)" },
  { id: 25, formal_name: "IEC 62196-2 Type 2", is_discontinued: false, is_obsolete: false, title: "Type 2 (Socket Only)" },
  { id: 1036, formal_name: "IEC 62196-2", is_discontinued: false, is_obsolete: false, title: "Type 2 (Tethered Connector) " },
  { id: 29, formal_name: "Type I/AS 3112/CPCS-CCC", is_discontinued: false, is_obsolete: false, title: "Type I (AS 3112)" },
  { id: 1043, formal_name: "IEC Type M (SANS 164-1, IS 1293:2005)", is_discontinued: false, is_obsolete: false, title: "Type M" },
  { id: 0, formal_name: "Not Specified", is_discontinued: nil, is_obsolete: nil, title: "Unknown" },
  { id: 24, formal_name: nil, is_discontinued: false, is_obsolete: false, title: "Wireless Charging" },
  { id: 21, formal_name: nil, is_discontinued: false, is_obsolete: false, title: "X"}
]

connection_types_data.each do |connection_type_data|
  ConnectionType.find_or_create_by!(id: connection_type_data[:id]) do |connection_type|
    connection_type.formal_name = connection_type_data[:formal_name]
    connection_type.is_discontinued = connection_type_data[:is_discontinued]
    connection_type.is_obsolete = connection_type_data[:is_obsolete]
    connection_type.title = connection_type_data[:title]
  end
end

amenities_data.each do |amenity_data|
  Amenity.find_or_create_by!(id: amenity_data[:id]) do |amenity|
    amenity.title = amenity_data[:title]
  end
end

current_types_data.each do |current_type_data|
  CurrentType.find_or_create_by!(id: current_type_data[:id]) do |current_type|
    current_type.description = current_type_data[:description]
    current_type.title = current_type_data[:title]
  end
end

countries_data.each do |country_data|
  Country.find_or_create_by!(
    id: country_data[:id] 
  ) do |country|  
    country.iso_code = country_data[:iso_code]
    country.continent_code = country_data[:continent_code]
    country.title = country_data[:title]
  end
end

source_data.each do |source_data|
  Source.find_or_create_by!(id: source_data[:id]) do |source|
    source.title = source_data[:title]
  end
end

usage_types_data.each do |usage_type_data|
  UsageType.find_or_create_by!(id: usage_type_data[:id]) do |usage_type|
    usage_type.is_pay_at_location = usage_type_data[:is_pay_at_location]
    usage_type.is_membership_required = usage_type_data[:is_membership_required]
    usage_type.is_access_key_required = usage_type_data[:is_access_key_required]
    usage_type.title = usage_type_data[:title]
  end
end

# ConnectionType.create([
#   {
#     id: 7,
#     formal_name: "Avcon SAE J1772-2001",
#     is_discontinued: true,
#     is_obsolete: false,
#     title: "Avcon Connector"
#   },
#   {
#     id: 4,
#     formal_name: nil,
#     is_discontinued: nil,
#     is_obsolete: nil,
#     title: "Blue Commando (2P+E)"
#   },
#   {
#     id: 3,
#     formal_name: "BS1363 / Type G",
#     is_discontinued: nil,
#     is_obsolete: nil,
#     title: "BS1363 3 Pin 13 Amp"
#   },
#   {
#     id: 32,
#     formal_name: "IEC 62196-3 Configuration EE",
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "CCS (Type 1)"
#   },
#   {
#     id: 33,
#     formal_name: "IEC 62196-3 Configuration FF",
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "CCS (Type 2)"
#   },
#   {
#     id: 16,
#     formal_name: nil,
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "CEE 3 Pin"
#   },
#   {
#     id: 17,
#     formal_name: nil,
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "CEE 5 Pin"
#   },
#   {
#     id: 28,
#     formal_name: "CEE 7/4",
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "CEE 7/4 - Schuko - Type F"
#   },
#   {
#     id: 23,
#     formal_name: nil,
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "CEE 7/5"
#   },
#   {
#     id: 18,
#     formal_name: nil,
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "CEE+ 7 Pin"
#   },
#   {
#     id: 2,
#     formal_name: "IEC 62196-3 Configuration AA",
#     is_discontinued: nil,
#     is_obsolete: nil,
#     title: "CHAdeMO"
#   },
#   {
#     id: 13,
#     formal_name: "Europlug 2-Pin (CEE 7/16)",
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "Europlug 2-Pin (CEE 7/16)"
#   },
#   {
#     id: 1038,
#     formal_name: "GB-T AC - GB/T 20234.2 (Socket)",
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "GB-T AC - GB/T 20234.2 (Socket)"
#   },
#   {
#     id: 1039,
#     formal_name: "GB-T AC - GB/T 20234.2 (Tethered Cable)",
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "GB-T AC - GB/T 20234.2 (Tethered Cable)"
#   },
#   {
#     id: 1040,
#     formal_name: "GB-T DC - GB/T 20234.3",
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "GB-T DC - GB/T 20234.3"
#   },
#   {
#     id: 34,
#     formal_name: "IEC 60309 3-pin",
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "IEC 60309 3-pin"
#   },
#   {
#     id: 35,
#     formal_name: "IEC 60309 5-pin",
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "IEC 60309 5-pin"
#   },
#   {
#     id: 5,
#     formal_name: "Large Paddle Inductive",
#     is_discontinued: true,
#     is_obsolete: true,
#     title: "LP Inductive"
#   },
#   {
#     id: 27,
#     formal_name: "SAE J3400",
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "NACS / Tesla Supercharger"
#   },
#   {
#     id: 10,
#     formal_name: nil,
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "NEMA 14-30"
#   },
#   {
#     id: 11,
#     formal_name: nil,
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "NEMA 14-50"
#   },
#   {
#     id: 22,
#     formal_name: "NEMA 5-15R",
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "NEMA 5-15R"
#   },
#   {
#     id: 9,
#     formal_name: nil,
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "NEMA 5-20R"
#   },
#   {
#     id: 15,
#     formal_name: nil,
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "NEMA 6-15"
#   },
#   {
#     id: 14,
#     formal_name: nil,
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "NEMA 6-20"
#   },
#   {
#     id: 1042,
#     formal_name: nil,
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "NEMA TT-30R"
#   },
#   {
#     id: 36,
#     formal_name: nil,
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "SCAME Type 3A (Low Power)"
#   },
#   {
#     id: 26,
#     formal_name: "IEC 62196-2 Type 3",
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "SCAME Type 3C (Schneider-Legrand)"
#   },
#   {
#     id: 6,
#     formal_name: "Small Paddle Inductive",
#     is_discontinued: true,
#     is_obsolete: true,
#     title: "SP Inductive"
#   },
#   {
#     id: 1037,
#     formal_name: "T13/ IEC Type J",
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "T13 - SEC1011 ( Swiss domestic 3-pin ) - Type J"
#   },
#   {
#     id: 30,
#     formal_name: nil,
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "Tesla (Model S/X)"
#   },
#   {
#     id: 8,
#     formal_name: "Tesla Connector",
#     is_discontinued: true,
#     is_obsolete: false,
#     title: "Tesla (Roadster)"
#   },
#   {
#     id: 31,
#     formal_name: "Tesla Battery Swap Station",
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "Tesla Battery Swap"
#   },
#   {
#     id: 1041,
#     formal_name: "AS/NZS 3123 Three Phase",
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "Three Phase 5-Pin (AS/NZ 3123)"
#   },
#   {
#     id: 1,
#     formal_name: "SAE J1772-2009",
#     is_discontinued: nil,
#     is_obsolete: nil,
#     title: "Type 1 (J1772)"
#   },
#   {
#     id: 25,
#     formal_name: "IEC 62196-2 Type 2",
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "Type 2 (Socket Only)"
#   },
#   {
#     id: 1036,
#     formal_name: "IEC 62196-2",
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "Type 2 (Tethered Connector) "
#   },
#   {
#     id: 29,
#     formal_name: "Type I/AS 3112/CPCS-CCC",
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "Type I (AS 3112)"
#   },
#   {
#     id: 1043,
#     formal_name: "IEC Type M (SANS 164-1, IS 1293:2005)",
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "Type M"
#   },
#   {
#     id: 0,
#     formal_name: "Not Specified",
#     is_discontinued: nil,
#     is_obsolete: nil,
#     title: "Unknown"
#   },
#   {
#     id: 24,
#     formal_name: nil,
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "Wireless Charging"
#   },
#   {
#     id: 21,
#     formal_name: nil,
#     is_discontinued: false,
#     is_obsolete: false,
#     title: "XLR Plug (4 pin)"
#   }
# ]
# )

# UsageType.create([
#   {
#     id: 0,
#     is_pay_at_location: nil,
#     is_membership_required: nil,
#     is_access_key_required: nil,
#     title: "(Unknown)"
#   },
#   {
#     id: 6,
#     is_pay_at_location: false,
#     is_membership_required: false,
#     is_access_key_required: false,
#     title: "Private - For Staff, Visitors or Customers"
#   },
#   {
#     id: 2,
#     is_pay_at_location: nil,
#     is_membership_required: true,
#     is_access_key_required: nil,
#     title: "Private - Restricted Access"
#   },
#   {
#     id: 3,
#     is_pay_at_location: nil,
#     is_membership_required: nil,
#     is_access_key_required: nil,
#     title: "Privately Owned - Notice Required"
#   },
#   {
#     id: 1,
#     is_pay_at_location: nil,
#     is_membership_required: nil,
#     is_access_key_required: nil,
#     title: "Public"
#   },
#   {
#     id: 4,
#     is_pay_at_location: false,
#     is_membership_required: true,
#     is_access_key_required: true,
#     title: "Public - Membership Required"
#   },
#   {
#     id: 7,
#     is_pay_at_location: false,
#     is_membership_required: false,
#     is_access_key_required: false,
#     title: "Public - Notice Required"
#   },
#   {
#     id: 5,
#     is_pay_at_location: true,
#     is_membership_required: false,
#     is_access_key_required: false,
#     title: "Public - Pay At Location"
#   }
# ])

# Amenity.create([
#     {id: 1, title: "Toilets"},
#     {id: 2, title: "Shopping Mall"},
#     {id: 3, title: "Restaurant"},
#     {id: 4, title: "Hotel"},
#     {id: 5, title: "Parking Lot"},
#     {id: 6, title: "ATM"},
#     {id: 7, title: "WiFi"},
#     {id: 8, title: "Park"},
#     {id: 9, title: "Supermarket"},
# ])

# CurrentType.create([
#   {
#     description: "Alternating Current - Single Phase",
#     id: 10,
#     title: "AC (Single-Phase)"
#   },
#   {
#     description: "Alternating Current - Three Phase",
#     id: 20,
#     title: "AC (Three-Phase)"
#   },
#   {
#     description: "Direct Current",
#     id: 30,
#     title: "DC"
#   }
# ])
