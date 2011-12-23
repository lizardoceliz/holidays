class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.boolean :remember_me
      t.belongs_to :user

      t.timestamps
    end
    add_index :customers, :user_id
  end
end
