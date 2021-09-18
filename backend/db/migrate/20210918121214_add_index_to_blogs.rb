class AddIndexToBlogs < ActiveRecord::Migration[6.1]
  def change
    add_index :blogs, :url, unique: true
  end
end
