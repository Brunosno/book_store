class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.decimal :total, precision: 10, scale: 2, null: false
      t.datetime :date, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.integer :status_order, null: false, default: 0

      t.references :user, null: false, foreign_key: { to_table: :persons }
      t.references :address, null: false, foreign_key: { to_table: :addresses }

      t.timestamps
    end
  end
end
