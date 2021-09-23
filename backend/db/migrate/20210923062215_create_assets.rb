class CreateAssets < ActiveRecord::Migration[6.1]
  def change
    create_table :assets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :file, null: false
      t.string :alt, null: false, limit: 40, default: "alt"

      t.timestamps
    end
  end
end
