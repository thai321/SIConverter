# SIConverter
[![Build Status](https://travis-ci.org/thai321/SIConverter.svg?branch=master)](https://travis-ci.org/thai321/SIConverter)

- Live: https://si-converter.herokuapp.com/
- Travis CI: https://travis-ci.org/thai321/SIConverter

-----

## Introduction
- A web service that perform unit conversion to SI from its counterparts. The endpoint API can be accessed from `units/si`.
- Enter a units you would like to convert by submit a GET request to the url path:
    - `units/si?units="YOUR INPUT"`
- Example:
    - `units/si?units=degree*ha/minute` would yield:
      ```json
      {
        "unit_name": "rad*m^2/s",
        "multiplication_factor": 2.9088820866572
      }
      ```

-------
## Setup
1. Start PostgreSQL on your PC
2. `git clone git@github.com:thai321/SIConverter.git`
3. Navigate to the project folder: `cd SIConverter`

#### Setup with bash script file `setup.sh`
- Run `./bin/setup.sh`
    - If `permission denied`, run `chmod u+x ./bin/setup.sh`
    - Then re-run `./bin/setup.sh`


#### Setup manually
1. Install Ruby Gem: `bundle install`
2. Setup model, database, and seeding: `rails db:reset`
3. Setup data for testing: `rails db:seed RAILS_ENV=test`

#### Testing:
- Run: `bundle exec rspec`
- Test can be found in the rspec folder:
    - [Models][model]
    - [Controllers: units][units]
    - [Concerns: units][concerns]

[model]: spec/models
[units]: spec/controllers/units
[concerns]: spec/controllers/concerns

-------
## API endpoint access:

- API url: https://si-converter.herokuapp.com/units/si?units=


- **Example**:
    - `https://si-converter.herokuapp.com/units/si?units=hour/second*L*d/ha/t` [[Link]](https://si-converter.herokuapp.com/units/si?units=hour/second*L*d/ha/t)
        ```json
        {
          "unit_name": "s/rad*m^3*s/m^2/kg",
          "multiplication_factor": 6415.660533509686
        }
        ```
    - `https://si-converter.herokuapp.com/units/si?units=h/(%22*litre*day)/(hectare/%C2%B0)*(min/L)` [[Link]](https://si-converter.herokuapp.com/units/si?units=h/(%22*litre*day)/(hectare/%C2%B0)*(min/L))

        ```json
        {
          "unit_name": "s/(rad*m^3*s)/(m^2/rad)*(s/m^3)",
          "multiplication_factor": 900000
        }
        ```

-------
## Database Schema


#### `SiUnit`

| column name   |      data type      |  details |
|----------|:-------------:|------:|
| `id` |  integer | not null, primary key  |
| `unit` |  string |  indexed, not null |
| `factor` |    float   |  indexed, not null |

- has_one `:si_name_symbol`

#### `SiNameSymbol`

| column name   |      data type      |  details |
|----------|:-------------:|------:|
| `id` |  integer | not null, primary key  |
| `name` |  string |  indexed, unique |
| `symbol` |    string   |  indexed, unique, not null |
| `si_type` | string |  not null |
| `si_unit_id` | integer |   indexed, not null |

- belongs_to `:si_unit`


#### Seed data:
```ruby
min = SiUnit.create(unit: "s", factor: 60)
hour = SiUnit.create(unit: "s", factor: 3600)
day = SiUnit.create(unit: "s", factor: 86400)
degree = SiUnit.create(unit: "rad", factor: Math::PI/180)
min_plane_angle = SiUnit.create(unit: "rad", factor: Math::PI/10800)
second = SiUnit.create(unit: "rad", factor: Math::PI/648000)
hectare = SiUnit.create(unit: "m^2", factor: 10**4)
litre = SiUnit.create(unit: "m^3", factor: 0.001)
tonne = SiUnit.create(unit: "kg", factor: 10**3)


SiNameSymbol.create(name: "minute", symbol: "min", si_type: "time", si_unit_id: min.id)
SiNameSymbol.create(name: "hour", symbol: "h", si_type: "time", si_unit_id: hour.id)
SiNameSymbol.create(name: "day", symbol: "d", si_type: "time", si_unit_id: day.id)
SiNameSymbol.create(name: "degree", symbol: "°", si_type: "Plane angle", si_unit_id: degree.id)
SiNameSymbol.create(symbol: "'", si_type: "Plane angle", si_unit_id: min_plane_angle.id)
SiNameSymbol.create(name: "second", symbol: "\"", si_type: "Plane angle", si_unit_id: second.id)
SiNameSymbol.create(name: "hectare", symbol: "ha", si_type: "area", si_unit_id: hectare.id)
SiNameSymbol.create(name: "litre", symbol: "L", si_type: "volume", si_unit_id: litre.id)
SiNameSymbol.create(name: "tonne", symbol: "t", si_type: "mass", si_unit_id: tonne.id)
```


------

[si_conversion]: app/controllers/concerns/si_conversion.rb
[infix_to_postfix]: app/controllers/concerns/si_conversion.rb
[si_evaluator]: app/controllers/concerns/si_evaluator.rb

## Implementation
- The main flow for this application can be found in [app/controllers/concerns/si_conversion.rb][si_conversion]
- The Class `SiUnitConversion` take an input from `params[:units]`. Convert the `si_string` from infix_oder to `postfix_order`. The logic can be found in : [app/controllers/concerns/infix_to_postfix.rb][infix_to_postfix]
- It gets si counter part which create a hash with its keys as name and symbol, and values as unit and factor. The logic can be found in the method `si_unit_to_hash` in [app/controllers/concerns/si_conversion.rb][si_conversion]
- It checks whether the given input is valid. If the given input is valid, then it evaluates the postfix expression, and get the unit names. Assign them to an json object with **unit_names** and **multiplication_factor**. The logic for **evaluate the postfix order** and get the **unit names** can be found in: [app/controllers/concerns/si_evaluator.rb][si_evaluator]

-----

## Testing
- Run test: `bundle exec rspec`
    - Test can be found in the rspec folder:
        - [Models][model]
        - [Controllers: units][units]
        - [Concerns: units][concerns]
