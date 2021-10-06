class AddIndexToStars < ActiveRecord::Migration[6.1]
  def change
    add_index :stars, [:user_id, :blog_id], unique: true
  end
end
