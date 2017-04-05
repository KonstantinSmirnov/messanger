class CreateDrafts < ActiveRecord::Migration[5.0]
  def change
    create_table :drafts do |t|
      t.string :recipient_email
      t.string :topic
      t.text :text
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
