class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.integer :user_id
      t.integer :customer_id
      t.datetime :holiday
      t.boolean :sent

      t.timestamps
    end
  end
end
