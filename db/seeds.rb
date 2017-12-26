
puts "Begin seeding ..."

SiNameSymbol.destroy_all
SiUnit.destroy_all

puts "Deleting the data from the table"

min = SiUnit.create(unit: "s", factor: 60)
hour = SiUnit.create(unit: "s", factor: 3600)
day = SiUnit.create(unit: "s", factor: 86400)
degree = SiUnit.create(unit: "rad", factor: Math::PI/180)
min_plane_angle = SiUnit.create(unit: "rad", factor: Math::PI/10800)
second = SiUnit.create(unit: "rad", factor: Math::PI/648000)
hectare = SiUnit.create(unit: "m^2", factor: 10**4)
litre = SiUnit.create(unit: "m^3", factor: 0.001)
tonne = SiUnit.create(unit: "kg", factor: 10**3)


puts "Create 9 si_units"

SiNameSymbol.create(name: "minute", symbol: "min", si_type: "time", si_unit_id: min.id)
SiNameSymbol.create(name: "hour", symbol: "h", si_type: "time", si_unit_id: hour.id)
SiNameSymbol.create(name: "day", symbol: "d", si_type: "time", si_unit_id: day.id)
SiNameSymbol.create(name: "degree", symbol: "°", si_type: "Plane angle", si_unit_id: degree.id)
SiNameSymbol.create(symbol: "'", si_type: "Plane angle", si_unit_id: min_plane_angle.id)
SiNameSymbol.create(name: "second", symbol: "\"", si_type: "Plane angle", si_unit_id: second.id)
SiNameSymbol.create(name: "hectare", symbol: "ha", si_type: "area", si_unit_id: hectare.id)
SiNameSymbol.create(name: "litre", symbol: "L", si_type: "volume", si_unit_id: litre.id)
SiNameSymbol.create(name: "tonne", symbol: "t", si_type: "mass", si_unit_id: tonne.id)

puts "Create 9 si_name_symbol"

puts "Finished seeding!"
