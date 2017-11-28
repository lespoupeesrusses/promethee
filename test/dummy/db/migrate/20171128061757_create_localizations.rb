class CreateLocalizations < ActiveRecord::Migration[5.1]
  def change
    create_table :localizations do |t|
      t.references :page, foreign_key: true
      t.string :data

      t.timestamps
    end
  end
end
