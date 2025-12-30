class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.integer :stock, null: false, default: 0
      t.boolean :available, null: false, default: true

      t.references :author, null: false, foreign_key: { to_table: :persons }

      t.timestamps
    end
  end
end
