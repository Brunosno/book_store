class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.decimal :price, precision: 10, scale: 2, null: false
      t.datetime :date, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.integer :status_order, null: false, default: 0

      t.references :person, null: true, foreign_key: { to_table: :persons }

      t.timestamps
    end
  end
end
