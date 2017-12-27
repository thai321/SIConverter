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
## Features
- Edge cases:
  - Given no units params, would yield:
    ```json
    {
      "error": "Units params is missing or empty"
    }
    ```
  - Invalid input:
    ```json
    {
      "error": "Invalid Input"
    }
    ```
- The application can handle the following types of input:
  - The input string contains **empty string**.
  - The input string contains **white spaces**.
  - The input string contains **nested parenthesis**.
  - The input string contains **parenthesis** part and **non-parenthesis** part.

---------
## API endpoint access:

- API URL: https://si-converter.herokuapp.com/units/si?units=

- https://si-converter.herokuapp.com/units/si?units=[YOUR-INPUT]


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


[seed]: db/seeds.rb
#### Seed data:
- [Link][seed]

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
[infix_to_postfix]: app/controllers/concerns/infix_to_postfix.rb
[si_evaluator]: app/controllers/concerns/si_evaluator.rb

## Implementation
- The main flow for this application can be found in [app/controllers/concerns/si_conversion.rb][si_conversion]
- The Class `SiUnitConversion` take an input from `params[:units]`. Convert the `si_string` from infix_oder to `postfix_order`. The logic can be found in : [app/controllers/concerns/infix_to_postfix.rb][infix_to_postfix]
- It gets si counter part which create a hash with its keys as name and symbol, and values as unit and factor. The logic can be found in the method `si_unit_to_hash` in [app/controllers/concerns/si_conversion.rb][si_conversion]
- It checks whether the given input is valid. If the given input is valid, then it evaluates the postfix expression, and get the unit names. Assign them to an json object with **unit_names** and **multiplication_factor**. The logic for **evaluate the postfix order** and get the **unit names** can be found in: [app/controllers/concerns/si_evaluator.rb][si_evaluator]

-----

## Complexity analysis
- Assume **N** is length of the input or **units params**
- Assume **K** is total number of name/symbol, and si units (factor, unit_name) from the database ([seed data][seed]). It's about **18** of them. 

| Method   |     Description      |  Time | Space |
|----------|:-------------:|------:| ------:|
| [infix_to_postfix_without_parenthesis][infix_to_postfix] |  Return an array of postfix order if the given si_string does not contain parenthesis | O(N)  |  O(N)  |
| [infix_to_postfix_with_parenthesis][infix_to_postfix] |  Return an array of postfix order if the given si_string contains parenthesis | O(N)  |  O(N)  |
| [valid_si_string?][si_conversion] |  Check whether the given si_string is the valid input |  O(N) |  O(1) |
| [check_for_parenthesis][si_conversion] |  Check whether the given si_string contain a parenthesis   |  O(N) |  O(1)  |
| [si_unit_to_hash][si_conversion] |  Create a hash with its keys as name and symbol, and values as unit and factor   |  O(K) |  O(K)  |
| [evaluate_postfix][si_evaluator] |  Evaluate the postfix order and return a floating number   |  O(N) |  O(1)  |
| [get_unit_names][si_evaluator] |  Return a unit names from the given input (units params)   |  O(N) |  O(N)  |
| Total |  ----   |  O(N + K) |  O(N + K)  |

------



## Testing
- Run test: `bundle exec rspec`
    - Test can be found in the rspec folder:
        - [Models][model]
        - [Controllers: units][units]
        - [Concerns: units][concerns]
