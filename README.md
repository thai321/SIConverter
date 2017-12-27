## SIConverter
[![Build Status](https://travis-ci.org/thai321/SIConverter.svg?branch=master)](https://travis-ci.org/thai321/SIConverter)

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
