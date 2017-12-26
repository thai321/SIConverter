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

require 'rails_helper'

RSpec.describe SiUnit, type: :model do

  describe "validations" do
    it { should validate_presence_of(:unit) }
    it { should validate_presence_of(:factor) }
  end

  describe "associations" do
    it { should have_one(:si_name_symbol) }
  end
end
