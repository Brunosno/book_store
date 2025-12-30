class CreatePhones < ActiveRecord::Migration[7.1]
  def change
    create_table :phones do |t|
      t.string :ddd, null: false
      t.string :number, null: false
      t.references :person, null: true, foreign_key: { to_table: :persons }

      t.timestamps
    end
  end
end
