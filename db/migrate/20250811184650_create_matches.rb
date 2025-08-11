class CreateMatches < ActiveRecord::Migration[8.0]
  def change
    create_table :matches do |t|
      t.references :application_one, null: false, foreign_key: { to_table: :applications }
      t.references :application_two, null: false, foreign_key: { to_table: :applications }
      t.references :admin, null: false, foreign_key: true
      t.datetime :matched_at, null: false

      t.timestamps
    end
    
    add_index :matches, [:application_one_id, :application_two_id], unique: true
    add_index :matches, :matched_at
  end
end
