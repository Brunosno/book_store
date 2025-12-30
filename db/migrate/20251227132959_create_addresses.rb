class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :street, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :cep, null: false

      t.references :person, null: true, foreign_key: { to_table: :persons }

      t.timestamps
    end
  end
end
