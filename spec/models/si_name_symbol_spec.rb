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

require 'rails_helper'

RSpec.describe SiNameSymbol, type: :model do

  describe "validations" do
    it { should validate_presence_of(:symbol) }
    it { should validate_presence_of(:si_type) }
  end

  describe "associations" do
    it { should belong_to(:si_unit) }
  end
end
