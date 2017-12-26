# == Schema Information
#
# Table name: si_units
#
#  id     :integer          not null, primary key
#  unit   :string           not null
#  factor :float            not null
#
# Indexes
#
#  index_si_units_on_factor  (factor)
#  index_si_units_on_unit    (unit)
#

class SiUnit < ApplicationRecord
  validates :unit, :factor, presence: true

  has_one :si_name_symbol,
    primary_key: :id,
    foreign_key: :si_unit_id,
    class_name: :SiNameSymbol,
    inverse_of: :si_unit
end
