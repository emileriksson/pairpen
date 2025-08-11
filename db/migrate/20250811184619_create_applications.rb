class CreateApplications < ActiveRecord::Migration[8.0]
  def change
    create_table :applications do |t|
      t.string :email, null: false
      t.text :application_text, null: false
      t.string :status, null: false, default: 'unverified'
      t.string :verification_token, null: false
      t.string :status_token, null: false
      t.datetime :verified_at

      t.timestamps
    end
    
    add_index :applications, :email
    add_index :applications, :verification_token, unique: true
    add_index :applications, :status_token, unique: true
    add_index :applications, :status
  end
end
