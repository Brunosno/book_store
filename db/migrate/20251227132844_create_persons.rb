class CreatePersons < ActiveRecord::Migration[7.1]
  def change
    create_table :persons do |t|
      t.string :type, null: false

      t.string :name, null: false
      t.string :email
      t.string :username
      t.string :password_digest
      t.boolean :is_admin, null: false, default: false
      t.text :biography

      t.timestamps
    end
  end
end
