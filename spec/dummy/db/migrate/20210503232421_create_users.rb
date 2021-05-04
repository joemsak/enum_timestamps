class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.integer :status, null: false, default: 0

      t.timestamps
    end

    add_index :users, :status
  end
end
