class CreateAttachments < ActiveRecord::Migration[7.0]
  def change
    create_table :attachments do |t|
      t.references :attachable, polymorphic: true
      t.string :attachment

      t.timestamps
    end
  end
end
