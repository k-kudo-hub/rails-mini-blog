class CreateBlogs < ActiveRecord::Migration[6.1]
  def change
    create_table :blogs do |t|
      t.references :user,             null: false, foreign_key: true
      t.string     :subject,          null: false, default: "untitled"
      t.text       :body
      t.string     :cover_image
      t.integer    :state_number,     null: false, limit: 1, default: 0
      t.string     :url,              null: false, limit: 50

      t.timestamps
    end
  end
end
