class CreateSiNameSymbols < ActiveRecord::Migration[5.1]
  def change
    create_table :si_name_symbols do |t|
      t.string :name
      t.string :symbol, null: false
      t.string :si_type, null: false
      t.integer :si_unit_id, null: false
    end

    add_index :si_name_symbols, :name, unique: true
    add_index :si_name_symbols, :symbol, unique: true
    add_index :si_name_symbols, :si_unit_id, unique: true
  end
end
