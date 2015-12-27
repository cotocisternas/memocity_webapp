class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.text :content
      t.datetime :when_activate
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :reminders, [:user_id, :created_at]
  end
end
