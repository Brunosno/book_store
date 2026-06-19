class AddNicknameToAddresses < ActiveRecord::Migration[8.0]
  def change
    add_column :addresses, :nickname, :string, null: true
  end
end
