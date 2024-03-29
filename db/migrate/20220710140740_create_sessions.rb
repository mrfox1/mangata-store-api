class CreateSessions < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'uuid-ossp'
    enable_extension 'pgcrypto'

    create_table :sessions, id: :uuid do |t|
      t.references :user

      t.timestamps
    end
  end
end
