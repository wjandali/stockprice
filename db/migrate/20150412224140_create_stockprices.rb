class CreateStockprices < ActiveRecord::Migration
  def change
    create_table :stockprices do |t|
      t.float :price, null: false
      t.string :symbol, null: false
      t.string :name, null: false
      t.date :date, null: false

      t.timestamps
    end

    add_index(:stockprices, [:date, :symbol], unique: true)
  end
end
