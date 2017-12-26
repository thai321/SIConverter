# == Schema Information
#
# Table name: si_name_symbols
#
#  id         :integer          not null, primary key
#  name       :string
#  symbol     :string           not null
#  si_type    :string           not null
#  si_unit_id :integer          not null
#
# Indexes
#
#  index_si_name_symbols_on_name        (name) UNIQUE
#  index_si_name_symbols_on_si_unit_id  (si_unit_id) UNIQUE
#  index_si_name_symbols_on_symbol      (symbol) UNIQUE
#

class SiNameSymbol < ApplicationRecord
  validates :symbol, :si_type, presence: true

  belongs_to :si_unit,
    primary_key: :id,
    foreign_key: :si_unit_id,
    class_name: :SiUnit,
    inverse_of: :si_name_symbol
end
