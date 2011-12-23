class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
      t.string :name
      t.integer :month
      t.integer :day
      t.belongs_to :user

      t.timestamps
    end
    add_index :holidays, :user_id
  end
end
