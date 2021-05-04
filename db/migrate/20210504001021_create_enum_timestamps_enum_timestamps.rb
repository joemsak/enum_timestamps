class CreateEnumTimestampsEnumTimestamps < ActiveRecord::Migration[6.1]
  def change
    create_table :enum_timestamps do |t|
      t.integer :model_id, null: false, foreign_key: true
      t.string :model_type, null: false
      t.string :field_name, null: false
      t.integer :identifier, null: false, default: 0

      t.timestamps
    end

    add_index :enum_timestamps,
      [:model_id, :model_type, :field_name, :identifier],
      unique: true,
      name: :enum_timestamps_unique_index

    add_index :enum_timestamps, [:model_id, :model_type]
    add_index :enum_timestamps, [:field_name, :identifier]
    add_index :enum_timestamps, :field_name
    add_index :enum_timestamps, :identifier
  end
end
