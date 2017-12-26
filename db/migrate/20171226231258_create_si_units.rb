class CreateSiUnits < ActiveRecord::Migration[5.1]
  def change
    create_table :si_units do |t|
      t.string :unit, null: false
      t.float :factor, null: false
    end

    add_index :si_units, :unit
    add_index :si_units, :factor
  end
end
