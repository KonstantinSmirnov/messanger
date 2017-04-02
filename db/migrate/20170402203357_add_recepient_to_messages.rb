class AddRecepientToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :recipient_id, :integer
    rename_column :messages, :user_id, :sender_id
  end
end
